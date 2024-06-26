<table align="center">
  <tr>
    <th>Component</th>
    <th>Name</th>
    <th>Conf</th>
    <th>Binds</th>
    <th>Theme</th>
  </tr>
  <tr>
    <td>OS</td>
    <td>Debian 12</td>
    <td>----</td>
    <td>----</td>
    <td><a href="https://github.com/Skalyaeve/a-linux-theme">a-linux-theme</a></td>
  </tr>
  <tr>
    <td>DE</td>
    <td>----</td>
    <td>----</td>
    <td>----</td>
    <td>----</td>
  </tr>
  <tr>
    <td>WM</td>
    <td>i3</td>
    <td><a href="https://github.com/Skalyaeve/a-setup/blob/main/resource/gui/i3/config">config</a></td>
    <td><a href="https://github.com/Skalyaeve/a-setup/blob/main/resource/gui/i3/binds.conf">binds.conf</a></td>
    <td>----</td>
  </tr>
  <tr>
    <td>Shell</td>
    <td>Bash</td>
    <td><a href="https://github.com/Skalyaeve/a-setup/blob/main/resource/terminal/bash/.bashrc">.bashrc</a></td>
    <td><a href="https://github.com/Skalyaeve/a-setup/blob/main/resource/terminal/bash/.bash_aliases">.bash_aliases</a></td>
    <td>----</td>
  </tr>
  <tr>
    <td>Terminal</td>
    <td>Alacritty</td>
    <td><a href="https://github.com/Skalyaeve/a-setup/blob/main/resource/terminal/alacritty/alacritty.yml">alacritty.yml</a></td>
    <td><a href="https://github.com/Skalyaeve/a-setup/blob/main/resource/terminal/bash/.inputrc">.inputrc</a></td>
    <td><a href="https://github.com/Skalyaeve/a-setup/blob/main/resource/terminal/alacritty/alacritty.yml">alacritty.yml</a></td>
  </tr>
  <tr>
    <td>IDE</td>
    <td>Neovim</td>
    <td><a href="https://github.com/Skalyaeve/a-setup/blob/main/resource/ide/nvim/init.lua">init.lua</a></td>
    <td><a href="https://github.com/Skalyaeve/a-setup/blob/main/resource/ide/nvim/lua/binds.lua">binds.lua</a></td>
    <td><a href="https://github.com/Skalyaeve/a-nvim-theme">a-nvim-theme</a></td>
  </tr>
  <tr>
    <td>Browser</td>
    <td>Firefox</td>
    <td>----</td>
    <td>----</td>
    <td><a href="https://github.com/Skalyaeve/a-firefox-theme">a-firefox-theme</a></td>
  </tr>
</table>

## <p align="center">From</p>

<img align="center" src="https://github.com/Skalyaeve/images-1/blob/main/screenshot/setup-from.png?raw=true"></img>

## <p align="center">To</p>

<img align="center" src="https://github.com/Skalyaeve/images-1/blob/main/screenshot/setup-to.png?raw=true"></img>

> Launcher menu: [a-linux-launcher](https://github.com/Skalyaeve/a-linux-launcher)

# A script

> - To quickly setup any Debian `$HOME`/system
> - To keep updated git/web resources
> - To group tools & configurations

## Usage

```sh
setup [options]
```

From a `resource` directory:
* Install/Update apt packages via `.apt` files
* Install/Update pip packages via `.pip` files
* Install/Update node packages via `.npm` files
* Install local resources via `.local` files
* Run scripts from `.run` folders

### Options

- `-u`/`--user` `<user>`
    * Install for specified `<user>`
- `-p`/`--path` `<path>`
    * Specify a path to `resource` directory
    * Default: `~/.local/share/setup`
- `-e`/`--exclude` `<dir1> [dir2]`...
    * Exclude specified directories
- `--no-apt`
    * Do not read `.apt` files
- `--no-pip`
    * Do not read `.pip` files
- `--no-npm`
    * Do not read `.npm` files
- `--no-local`
    * Do not read `.local` files
- `--no-run`
    * Do not read `.run` folders

### `.apt` & `.pip` & `.npm` files

- `<package_name>`
- 1 package per line

### `.local` files

- Swap files/folders from `$(dirname .local)`
- `<path from .local file> @ <target DIRECTORY>`
- 1 line per swap

### `.run` folders

- Per subdirectory:
    * 1 `install.sh` bash script
    * 1 `update.sh` bash script (opt)

## Install

```sh
mkdir -p ~/.config
mkdir -p ~/.local/src
mkdir -p ~/.local/bin
mkdir -p ~/.local/share
sudo apt update -y
sudo apt install -y python3
sudo apt install -y python3-venv
sudo apt install -y nodejs
sudo apt install -y npm
```

```sh
dst=~/.local/src/setup
git clone https://github.com/Skalyaeve/a-setup.git $dst
cd $dst
```

```sh
dst=~/.local/share/setup
mkdir -p $dst
ln -s $PWD/resource $dst/resource
ln -s $PWD/setup.sh ~/.local/bin/setup
python3 -m venv ~/.local/share/pyenv
```

Edit `resource` directory to your needs, then:

```sh
export PATH=$HOME/.local/bin:$PATH
setup
```

or

```sh
sudo ln -s ~/.local/bin/setup /usr/local/bin/setup
sudo setup -u $USER
```

