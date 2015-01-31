# zgithist

Zsh - Git repository history

## Purpose

* To add a history management in every repository
* Originally, this plugin was developed for Zsh.
    * Named as "zgithist"

## Usage

This plugin automatically collects command history in every git repository.
When you want to see history, type `repository_history`.

## Installation

* Add some lines to your .zshenv from .zshenv of this project.
* Add some lines to your .zshrc from .zshrc of this project.
* Source zgithistory.zsh in your .zshrc.

## Note

This script will save history data in `$ZGITHISTORY_DIR` with base64 coded repository name. If there are 2 or more same name repositories, they will be treated as same repository.
If you want to limit maximum line in history file, please set variable `$ZGITHISTORY_MAXHIST` in .zshenv by following sample .zshenv.

## Todo

* To support Zsh autoload

## Licence

* NYSL (http://www.kmonos.net/nysl/) 0.9981

## Others

This project was moved from my [gist](https://gist.github.com/kmhjs/53c9cafb6b28f1904306)
