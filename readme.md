1. 安装terminator
1. 启动nvim，执行 :PlugInstall 安装插件
1. 执行`sudo pip install neovim` 安装python支持
1. 执行`sudo pip3 install neovim` 安装python3支持
1. 执行`sudo pip install pynvim` 安装python支持
1. 执行`sudo pip3 install pynvim` 安装python3支持

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

# 安装ccls
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

# 安装coc.vim

## apt 安装node.js：
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

## apt 安装yarn:
```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
```

## 安装node.js provider

```bash
npm install -g neovim
```

## 检查安装情况

进入nvim执行 :checkhealth 检查coc是否正确安装

## 配置coc.vim的ccls支持

安装coc的ccls支持：
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
    }
  }
}
```

# 安装Bear：
```
git clone --depth=1 https://github.com/rizsotto/Bear.git
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

