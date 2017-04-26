# Package.json scripts for Touchbar

> Displays package.json scripts in touchbar, a fork of [iam4x touchbar](https://github.com/iam4x/zsh-iterm-touchbar).

*WARNING!* You must not have any keys binded to function in order for this script to work as it overwrites F1-F12.

![preview1](./preview1.png)
![preview2](./preview2.png)

### Requirements

* iTerm2 3.1.beta.3 (OS 10.10+) - [Download](https://www.iterm2.com/downloads.html)
* [zsh](http://www.zsh.org/) shell

### Installing plugin

Clone the repo in your plugins directory:

* `$ cd ${ZSH_CUSTOM1:-$ZSH/custom}/plugins`
* `$ git clone https://github.com/seripap/pkgjson-iterm-touchbar.git`

### Configuring for NPM instead of yarn

In `pkgjson-iterm-touchbar.plugin.zsh`, modify useYarn to `false` on line 6.

Then add the plugin into your `~/.zshrc`:

```
plugins=(... pkgjson-iterm-touchbar)
```
