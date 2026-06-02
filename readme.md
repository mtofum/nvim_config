# Neovim 配置安装和迁移

当前配置使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理插件。迁移到新机器时，只需要把这个配置目录放到 `~/.config/nvim`，第一次启动时 lazy.nvim 会自动安装插件。

## 需要提交到 git 的内容

提交当前目录下的配置文件即可：

```text
init.lua
lua/
colors/
lazy-lock.json
readme.md
```

不要提交插件下载目录、Mason 安装目录和缓存：

```text
~/.local/share/nvim/lazy/
~/.local/share/nvim/mason/
~/.cache/nvim/
~/.local/state/nvim/
```

`lazy-lock.json` 需要提交，它用于锁定插件版本，保证迁移后安装到相同版本。

## 新机器安装步骤

1. 安装基础依赖。以 Debian/Ubuntu 为例：

```bash
sudo apt update
sudo apt install git neovim ripgrep fd-find nodejs npm python3 python3-pip gcc make unzip ibus
```

2. 克隆配置：

```bash
mkdir -p ~/.config
git clone <你的仓库地址> ~/.config/nvim
```

如果新机器上已经有 Neovim 配置，先备份：

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone <你的仓库地址> ~/.config/nvim
```

3. 同步插件：

```bash
nvim --headless "+Lazy! sync" "+qa"
```

4. 启动 Neovim：

```bash
nvim
```

5. 检查环境：

```vim
:checkhealth
:Lazy
:Mason
```

Mason 管理的 LSP server 通常不提交到 git。换机器后进入 `:Mason`，按需要安装缺失的 language server。

## IBus 输入法切换

`nvim-ibus-sw` 需要系统安装并启用 IBus：

```bash
ibus version
```

如果使用 GNOME，并希望每个窗口独立保存输入法状态，可以执行：

```bash
gsettings set org.gnome.desktop.input-sources per-window true
```

# 旧版手动依赖笔记

以下内容是早期 vim-plug/coc.vim 配置留下的手动安装笔记。当前 lazy.nvim 配置不需要执行 `:PlugInstall`。

1. 安装terminator
1. 执行`sudo pip install neovim` 安装python支持
1. 执行`sudo pip3 install neovim` 安装python3支持

# 安装ripgrep
\< ubuntu 18.10

```bash
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.1/ripgrep_11.0.1_amd64.deb
sudo dpkg -i ripgrep_11.0.1_amd64.deb
```

>= ubuntu 18.10

```bash
sudo apt install ripgrep
```

# 安装lsp服务：


## 安装ccls
安装clang, 根据自己的系统版本选择下载包的版本号:
```bash
wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
sudo mkdir -p /usr/local/lib/clang/
sudo tar -xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz -C /usr/local/lib/clang
* 如果编译器不是GCC 7.2以上的版本，编译会报错，需要升级GCC
```
下载代码：
```bash
git clone --recursive https://github.com/MaskRay/ccls
```

编译：
```
cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/usr/local/lib/clang/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
cmake --build Release
```
安装:
```
sudo cmake --build Release --target install
```

## 安装cmake lsp：
```
sudo python3 -m pip install cmake-language-server
```

# 安装coc.vim

## apt 安装node.js > ubuntu 18.04：
```
sudo apt install npm
```

## 手动安装node.js(以上步骤成功则跳过该步骤)

在[node.js](https://nodejs.org/zh-cn/download/)官网下载二进制包

```bash
sudo mkdir -p /usr/local/lib/nodejs
cd /usr/local/lib/nodejs
tar -Jxf node-v10.16.0-linux-x64.tar.xz .
```

在~/.zshrc中添加环境变量

```bash
export PATH=$PATH:/usr/local/lib/nodejs/node-v10.16.0-linux-x64/bin
```

## 安装node.js provider

```bash
npm install -g neovim
```

## 检查安装情况

进入nvim执行 :checkhealth 检查coc是否正确安装

## 配置coc.vim

安装coc的ccls和cmake支持：
启动vim，执行：`:CocConfig`打开配置文件，添加以下内容：
```
{
  "languageserver": {
    "ccls": {
      "command": "ccls",
      "filetypes": ["c", "cpp", "cuda", "objc", "objcpp"],
      "rootPatterns": [".ccls", "compile_commands.json", ".vim/", ".git/", ".hg/"],
      "initializationOptions": {
         "cache": {
           "directory": ".ccls-cache"
         }
       }
    },
    "cmake": {
      "command": "cmake-language-server",
      "filetypes": ["cmake"],
      "rootPatterns": [
        "build/"
      ],
      "initializationOptions": {
        "buildDirectory": "build"
      }
    }
  }
}
```

# 安装Bear：
```
https://github.com/rizsotto/Bear.git
cd Bear
mkdir build
cd build
cmake ../
make -j
sudo make install
```

#安装gtag组件
在[gtag官网](https://www.gnu.org/software/global/download.html)下载安装包
执行三部曲安装
```bash
./configure
make -j
sudo make install
```
