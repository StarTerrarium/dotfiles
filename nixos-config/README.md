# NixOS Configurations

## Usage
I use [nh](https://github.com/viperML/nh) for running most nixos commands.  eg.
```sh
nh os switch
```

## Bootstrap from fresh install
Note:  This is tested using my `thinknix` host.  An actual laptop who I had done some configuration on
       prior to reinstalling NixOS for the purpose of writing this bootstrap doco.
       It is also assumed that usernames match between what was selected in the installer, and in the nix config

### Initial setup
- Connect to a network.  I had no DE selected when installed, so I used `nmtui`
- We need git:  `nix-shell -p git`
- Now let's clone this repository:  `git clone https://github.com/StarTerrarium/dotfiles.git ~/.dotfiles`
- Now we want to copy our `/etc/nixos/hardware-configuration.nix` into the appropriate host in the cloned repo.
  This is because disk IDs and such will be different for every installation.  For my test run here I ran
  `cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/nixos-config/hosts/thinknix/`
- Now we can actually run `sudo nixos-rebuild boot --flake ~/.dotfiles/nixos-config`
- Reboot the system - the display manager, desktop environment, etc etc should all now be on the system.
- Remember to commit the hardware-configuration.nix change.
- From now on you can just us `nh os <command>` to apply changes.

### Things not in the nix config
Unfortunately not everything is (or can?) be managed entirely by the nixos config.  Here are some steps to take afterwards:

- Retrieve SSH keys from some secrets manager and place in `~/.ssh`
  - Remember to change their permissions, eg `chmod 400 ~/.ssh/my_ssh_key`
  - Check the `config` for the expected name of any keys used
- Install any Firefox addons desired
  - Logging into your Firefox account will sync addons
  - See [Yomichan Setup Tutorial](https://learnjapanese.moe/yomichan/) to find dictionaries for Yomitan
- Plasma configuration (oh how I wish plasma could be configured in a config file..)

## Todo
- Break things up into modules.  I'm just getting a barebones working set up for my laptop initially though
- Figure out how to configure Japanese input in nix.
- Figure out how to fix Japanese fonts in nix (see [this page](http://learnjapanese.moe/font/))
