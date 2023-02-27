# rofi-symbols
Small rofi script for typing/copying utf8 symbols.

![](https://github.com/IvyTheIV/rofi-symbols/blob/master/usage.gif)

## Features

+ Type mode - types the characters.
+ Copy mode - copies to clipboard.
+ Recently used characters are shown on top.
+ Ability to add your own characters/symbols/strings of characters.

## Dependencies

rofi, xclip, xdotool, awk, grep, sed

## Installation

```sh
git clone https://github.com/IvyTheIV/rofi-symbols.git; cd rofi-symbols
mkdir ~/.config/rofi/rofi-symbols
cp -r symbols ~/.config/rofi/rofi-symbols
```

## Usage

to run the script use the following commands:
```sh
rofi -show sym -modes "sym:path/to/the/script/rofi-symbols.sh" # for typing
rofi -show sym -modes "sym:path/to/the/script/rofi-symbols.sh copy" # for copying
```

Alternatively, put the shell script somewhere in $PATH:
```sh
cd ~/.local/bin
ln -s path/to/the/script/rofi-symbols.sh

rofi -show sym sym_c -modes "sym:rofi-symbols.sh","sym_c:rofi-symbols.sh copy"
```

## Custom symbols

You can put different symbols (or even strings of characters - as long as it doesn't contain spaces).
To do that, create a file in `~/.config/rofi/rofi-symbols/symbols/` ending with `.symbols`. Verbose, indeed.
Check the existing files for reference on the formatting.
