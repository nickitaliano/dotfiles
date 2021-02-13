# Macbook Pro Dotfiles Using Mackup

## A Fresh macOS Setup

These instructions are for when you've already set up your dotfiles. If you want to get started with your own dotfiles you can [find instructions below](#your-own-dotfiles).

### Before you re-install

First, go through the checklist below to make sure you didn't forget anything before you wipe your hard drive.

- Did you commit and push any changes/branches to your git repositories?
- Did you remember to save all important documents from non-iCloud directories?
- Did you save all of your work from apps which aren't synced through iCloud?
- Did you remember to export important data from your local database?
- Did you update [mackup](https://github.com/lra/mackup) to the latest version and ran `mackup backup`?

### Installing macOS cleanly

After going to our checklist above and making sure you backed everything up, we're going to cleanly install macOS with the latest release. Follow [this article](https://www.imore.com/how-do-clean-install-macos) to cleanly install the latest macOS version.

## Setting up your Mac

### Preparations

Nick Italiano's "." + "files" for Zsh, python, git, and more.

They assume you're using OSX.

Questions? Comments? Open an issue or tweet [@nickitalian0](https://twitter.com/nickitalian0).

### Installation

    $ git clone git@github.com:nickitaliano/dotfiles.git ~/.dotfiles
    $ cd ~/.dotfiles
    $ ./install.sh

It will install [rcm] and use that to safely symlink the dotfiles, prompting you
if a file already exists (like if you already have `~/.zshrc`).

[rcm]: http://thoughtbot.github.io/rcm/rcm.7.html

### Organization

`rcm` will symlink all files into place, keeping the folder structure relative
to the tag root. However, non-configuration files and folders like `system/`,
`Brewfile`, `README.md`, etc will not be linked because they are in the
`EXCLUDES` section of the [`rcrc`](/rcrc) file.

### Tags

`rcm` has the concept of tags: items under `tag-git/` are in the `git` tag, and
so on. I'm using it for organization.

### Zsh

All of the Zsh configuration is in [`zshrc`](/zshrc).

### iterm2

Install it manually from the [website](https://www.iterm2.com/), start it and add it to the deck.

Initial settings:

- Create a new profile in `Preferences > Profile` named `white`
     - `Colors > Color presets > Tango Light`
     - `Session > Status bar enabled` and `Configure Status Bar`. Add `git state`, `CPU utilization`, `Memory utilization`. Click `Auto-Rainbow`.
- Mark `white` profile and select `Other Actions > Set as default`.


### Git (XCode)

Install it on the command line first, it will ask for permission.

```
xcode-select --install
```

### Sudo

Note: I keep this disabled for improved security, though some sessions may require heavy sudo usage.

```
sudo vim /private/etc/sudoers.d/uname

#uname ALL=(ALL) NOPASSWD: ALL
```

## Essentials

### Tools
These tools are managed without Homebrew on purpose, e.g. for manual updates.

* Workflows: [Alfred](https://www.alfredapp.com/) including my Powerpack license
  * [HTTP Status Codes](https://github.com/ilstar/http_status_code)
  * [DNS: Dig](https://github.com/phallstrom/AlfredDig)
  * [Colors](https://github.com/zenorocha/alfred-workflows#colors-v202--download)
  * [Emoji](https://github.com/carlosgaldino/alfred-emoji-workflow)
  * [Encode/Decode](https://github.com/zenorocha/alfred-workflows#encodedecode-v180--download)
  * [Gmail](https://github.com/fniephaus/alfred-gmail)
  * [Gmail filters](https://github.com/inlet/alfred-workflow-gmail-filters)
  * [Sketch](https://madbitco.github.io/sketchflow/)
  * [Google Translate](https://github.com/xfslove/alfred-google-translate)
  * [Python Library](https://gitlab.com/deanishe/alfred-workflow)

### Virtualization and Containers

I only use Docker locally, required VMs run in Hetzner Cloud (private), GCP or AWS. Docker for Mac provides the `docker-compose` binary required to run demo environments. 

VirtualBox needs work with Kernel modules. I highly recommend to get a [Parallels license](https://www.parallels.com/de/products/desktop/buy/) instead. 

## Preferences
These are manual settings as they require user awareness.

### FileVault
See [here](https://support.apple.com/en-us/HT204837) for detailed instruction

### Keyboard

`Shortcuts`: Disable Spotlight in preparation for enabling Alfred next.

### Alfred

Start Alfred from the Applications folder, and change the hotkey to `Cmd+Space`.
Ensure that Spotlight is disabled in the system preferences.

### Finder

`Preferences > Sidebar` and add

- User home
- System root

## Additional Applications

* Google Chrome Canary
* Docker (account required)
* Spotify (account required)

### Handbook

Following the [GitLab handbook](https://about.gitlab.com/handbook/tools-and-tips/):

* [Loom](https://www.loom.com/)


### Homebrew

* Firefox (in order to reproduce UX bugs)
* VLC
* Wireshark

## Additional Hints

More insights can be found in these lists:

- [Setting examples](https://github.com/mathiasbynens/dotfiles/blob/master/.macos)
- [command overview](https://github.com/herrbischoff/awesome-macos-command-line).


## Upgrades

On major version upgrades, binaries might be incompatible or need a local rebuild. 
You can enforce a reinstall by running the two commands below, the second command
only reinstalls all application casks.

```
brew reinstall $(brew list)

brew reinstall $(brew list --cask)
```

When Xcode and compilers break, re-install the command line tools.

```
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install
```

If you did all of the above you may now follow these install instructions to setup a new Mac.

1. Update macOS to the latest version with the App Store
2. Install Xcode from the App Store, open it and accept the license agreement
3. Install macOS Command Line Tools by running `xcode-select --install`
4. [Generate a new public and private SSH key](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and add them to Github
5. Clone this repo to `~/.dotfiles`
6. Install [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh#getting-started)
6. Run `fresh.sh` to start the installation
7. After mackup is synced with your cloud storage, restore preferences by running `mackup restore`
8. Restart your computer to finalize the process

Your Mac is now ready to use!

> Note: you can use a different location than `~/.dotfiles` if you want. Just make sure you also update the reference in the [`.zshrc`](./.zshrc) file.

## Your Own Dotfiles

**Please note that the instructions below assume you already have set up Oh My Zsh so make sure to first [install Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh#getting-started) before you continue.**

If you want to start with your own dotfiles from this setup, it's pretty easy to do so. First of all you'll need to fork this repo. After that you can tweak it the way you want.

Go through the [`.macos`](./.macos) file and adjust the settings to your liking. You can find much more settings at [the original script by Mathias Bynens](https://github.com/mathiasbynens/dotfiles/blob/master/.macos) and [Kevin Suttle's macOS Defaults project](https://github.com/kevinSuttle/MacOS-Defaults).

Check out the [`Brewfile`](./Brewfile) file and adjust the apps you want to install for your machine. Use [their search page](https://caskroom.github.io/search) to check if the app you want to install is available.

Check out the [`aliases.zsh`](./aliases.zsh) file and add your own aliases. If you need to tweak your `$PATH` check out the [`path.zsh`](./path.zsh) file. These files get loaded in because the `$ZSH_CUSTOM` setting points to the `.dotfiles` directory. You can adjust the [`.zshrc`](./.zshrc) file to your liking to tweak your Oh My Zsh setup. More info about how to customize Oh My Zsh can be found [here](https://github.com/robbyrussell/oh-my-zsh/wiki/Customization).

When installing these dotfiles for the first time you'll need to backup all of your settings with Mackup. Install Mackup and backup your settings with the commands below. Your settings will be synced to iCloud so you can use them to sync between computers and reinstall them when reinstalling your Mac. If you want to save your settings to a different directory or different storage than iCloud, [checkout the documentation](https://github.com/lra/mackup/blob/master/doc/README.md#storage). Also make sure your `.zshrc` file is symlinked from your dotfiles repo to your home directory. 

```zsh
brew install mackup
mackup backup
```

You can tweak the shell theme, the Oh My Zsh settings and much more. Go through the files in this repo and tweak everything to your liking.

Enjoy your own Dotfiles!

## Thanks To...

I first got the idea for starting this project by visiting the [Github does dotfiles](https://dotfiles.github.io/) project. Both [Zach Holman](https://github.com/holman/dotfiles) and [Mathias Bynens](https://github.com/mathiasbynens/dotfiles) were great sources of inspiration. [Sourabh Bajaj](https://twitter.com/sb2nov/)'s [Mac OS X Setup Guide](http://sourabhbajaj.com/mac-setup/) proved to be invaluable. Dries's Dotfiles were edited for my base...

Thanks to [@subnixr](https://github.com/subnixr) for [his awesome Zsh theme](https://github.com/subnixr/minimal)! And lastly, I'd like to thank [Emma Fabre](https://twitter.com/anahkiasen) for [her excellent presentation on Homebrew](https://speakerdeck.com/anahkiasen/a-storm-homebrewin) which made me migrate a lot to a [`Brewfile`](./Brewfile) and [Mackup](https://github.com/lra/mackup).

## Attribution

Many scripts and configurations have been inspired by or outright stolen from
my colleagues at thoughtbot. Of special note, I've stolen many things from
[Chris Toomey], [Gordon Fontenot], and [Teo Ljungberg], among others that I'm
sure I'm forgetting.

[Chris Toomey]: https://github.com/christoomey/dotfiles
[Gordon Fontenot]: https://github.com/gfontenot/dotfiles
[Teo Ljungberg]: https://github.com/teoljungberg/dotfiles
