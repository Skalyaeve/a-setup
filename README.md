# A setup
| Component | Name | Conf |
|-|-|-|
| OS | Debian 12 | ---- |
| DE | ---- | ---- |
| WM | i3 | [i3/config](https://github.com/Skalyaeve/a-setup/blob/main/resource/gui/i3/config) |
| Shell | Bash | [.bashrc](https://github.com/Skalyaeve/a-setup/blob/main/resource/terminal/bash/.bashrc) |
| Terminal | Alacritty | [alacritty.yml](https://github.com/Skalyaeve/a-setup/blob/main/resource/terminal/alacritty/alacritty.yml) |
| IDE | Neovim | [init.lua](https://github.com/Skalyaeve/a-setup/blob/main/resource/ide/neovim/.init.lua) |

# A script

- To quickly setup any home directory / system
- To keep updated git and other web resources
- To regroup your different tools and configurations

### Usage
```sh
setup <command> [options]
```

#### Commands
- `install`:
    * Running from a `resource` directory
    * Install apt packages via .apt files
    * Run install.sh scripts from .script dirs
    * Install local resources via .swap files

- `restore`:
    * Running from a `backup` directory
    * Uninstall apt packages via diff file
    * Run remove.sh scripts
    * Restore local resources via diff file

#### Options:
- `-u`, `--user USER`:
    * Install/Backup for the specified user
- `-p`, `--path PATH`:
    * Specify a path to the resource/backup directory
    * Default: $HOME/.local/share/setup
- `-e`, `--exclude DIR[S]`:
    * When `install`, exclude the specified directories
- `--no-apt`:
    * When `install`, do not read `.apt` files
- `--no-script`:
    * When `install`, do not read `.script` files
- `--no-swap`:
    * When `install`, do not read `.swap` files
- `--no-backup`:
    * When `install`, do not create backup

#### .apt files
- `<package_name> : [description]`
- 1 package per line

#### .script dirs
- Per subdirectory:
    * 1 `install.sh` bash script
    * 1 optional `remove.sh` bash script

#### .swap files
- Swap files/directories from `$(dirname .swap)`
- To `cp` src instead of `ln -s`, add `no-link `
- `[no-link ]<path from .swap file> @ <target DIRECTORY>`
- 1 line per swap

## Install
```sh
dst=~/.local/src
git clone https://github.com/Skalyaeve/a-setup.git $dst/setup
cd $dst/setup
ln -s $PWD/setup.sh $HOME/.local/bin/setup
ln -s $PWD/resource $HOME/.local/share/setup/resource
```
Edit `resource` directory to your needs
```sh
export PATH=$HOME/.local/bin:$PATH
setup install
# or
# sudo ln -s $HOME/.local/bin/setup /bin/setup
# sudo setup install -u $USER
```

## Uninstall
```sh
count=$(ls ~/.local/share/setup/backup)
for _ in $count; do
    setup restore
    # or
    # sudo setup restore -u $USER
done
rm -rf ~/.local/share/setup
rm ~/.local/bin/setup
```

# Some tools
- [extract](https://github.com/Skalyaeve/a-setup/blob/main/resource/utils/bin/extract): Extract archives
- [setmenu](https://github.com/Skalyaeve/a-setup/blob/main/resource/utils/bin/setmenu): Set a [jgmenu csv](https://github.com/Skalyaeve/a-setup/blob/main/resource/gui/jgmenu/menu.csv) from a [directory](https://github.com/Skalyaeve/a-setup/blob/main/resource/gui/jgmenu/set/main)
- [gitpush](https://github.com/Skalyaeve/a-setup/blob/main/resource/utils/bin/extract): Commit and push repositories from a directory
- [codecount](https://github.com/Skalyaeve/a-setup/blob/main/resource/utils/bin/countdata): Count bytes of code from a directory, then give a percentage for each file type
