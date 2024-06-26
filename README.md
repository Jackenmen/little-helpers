# little-helpers

[![Sponsor on GitHub](https://img.shields.io/github/sponsors/Jackenmen?logo=github)](https://github.com/sponsors/Jackenmen)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A few *little* scripts for things I do often so that I can type less
or make fewer clicks.\
I'm just a bit lazy...

Scripts that aren't OS-specific (`bin/virt-*`, `bin/*.cmd`, `ahk_scripts/*`) have been tested on Linux and Windows.\
`bin/virt-*` scripts are Linux-specific and require `libvirt` and `virtinst` packages.\
`bin/*.cmd` and `ahk_scripts/*` scripts are Windows-specific.

## Usage/Installation

To use the scripts in this repo, you should first clone it:

```sh
git clone https://github.com/Jackenmen/little-helpers
```

### Scripts from the `bin/` directory

After you have the repository cloned into a folder, you just need to
add the `REPO_PATH/bin` folder to your `PATH`.

Scripts prefixed with `git-` are meant to be ran through `git`,
i.e. as `git pp`, not `git-pp`.\
This is possible thanks to git's support for external commands.

### Scripts from the `ahk_scripts/` directory

AutoHotkey scripts need to be lanched on system startup.\
For ease, I made *another* AHK script (`start_all_ahk_scripts.ahk`)
that starts all the scripts from the `ahk_scripts` folder.\
You should just add a shortcut to it in the `shell:startup` folder,
and the script will ensure that any scripts in the `ahk_scripts` folder,
will launch during system startup.

If you want to ignore some of those scripts,
you can put the names (including the `.ahk` extension) of them
in the `start_all_ahk_scripts.ignore` file.

---

## Available scripts (`bin/` directory)

### sp (Windows-only)

This script splits a pane vertically in Windows Terminal
and runs the given command in it,
while keeping focus on the pane it was ran from.

Usage: `sp <command...>`

### sshvbox (Windows-only)

This script allows you to start an SSH connection to a VirtualBox virtual machine
which uses the name that you provided to the command. It is assumed that the machine
is running an SSH server and all you really need is to get its IP address.

Handy as it doesn't require you to know VM's IP machine
as it's being fetched from VirtualBox automatically.

Usage: `sshvbox <machine name>`

### git-pp

This script is basically a shorter version of
`git pull upstream default_branch && git push`
with a few extra things that ensure, you're in the right branch
and it works no matter what name the default branch has.

Note: This works with an assumption that the remote for upstream is called `upstream`
and that the remote for your fork is called `origin`.

### git-checkoutpr

This script fetches and checks out a merge commit of the pull request
with a given number.

Usage: `git checkoutpr <pr_number> [branch]`

When `branch` is passed, the script will additionally create a branch
from PR's merge branch, rather than only do a checkout to a dangling commit.

Personally, I have this command aliased to `git copr` to type even less :)

Note: only works on GitHub and other services who provide merge commit refs
in a format of: `pull/PR_NUMBER/merge`

### git-checkoutdefault

This script just checks out the default branch.
I do it all the time, so why not make it simpler?

Personally, I have this command aliased to `git cod` to type even less :)

Note: This works with an assumption that
the default branch is set on a remote called `origin`

### git-br

This script shows a deduplicated list of local and remote branches along with
tracking remote and last commit's description, date, and its short hash.

The output is sorted in reverse chronological order and additionally favours
branches that are local-only or are only on the `origin` remote by showing them
before all other branches. This is meant to make it easier to find *your* recent work.

Each entry on the branch list takes two lines which, while making it less concise,
allows it to show more of the commit message and is, arguably, more readable.

### vm-run

This scripts run a temporary VM with the given Linux image.

Image's default user is set up with the `~/.ssh/id_rsa` key and additionally,
`vm` user with `vm` password and the aforementioned key is also created.

See documentation of `vm-image-add` for details about image management.

Usage: `vm-run <image_name>`

The domain (VM) name will be set to `tmp-<image_name>`, optionally suffixed with
a number (`tmp-<image_name>-2`) when a machine with same name exists.

### vm-connect

Connect to a VM created by `vm-run` or `libvirt`.

In case of VMs created by `vm-run`, `<vm_name>` is equivalent to image name
with a `tmp-` prefix and an optional `-N` suffix when multiple VMs with same name
are running at the same time, e.g. `tmp-ubuntu2204` or `tmp-ubuntu2204-2`.

Usage: `vm-connect <vm_name>`

### vm-image-add

Add a Linux VM image for use by `vm-run`.

Usage: `vm-image-add <image_name> <sums_url> <sum_type> <filename_pattern>`

The script expects to be able to download a Linux image based on
a provided `CHECKSUMS` file in a format returned by `sha256sum`/`sha512sum` program
ran with or without `--tag` option. `<filename_pattern>` is used to extract
the relevant checksum. This setup is generally supported by the data that is provided
by the distro maintainers though there are 2 notable outliers:
- Red Hat Enterprise Linux - requires subscription
- Oracle Linux - does not provide checksum file in a parsable format

You can find examples for different distros at:
https://github.com/Jackenmen/dotfiles/tree/main/private_dot_config/little-helpers-vm-images

### vm-image-fetch

Fetch latest Linux VM image (added through `vm-image-add`) with the given name.

This tool is typically invoked automatically.

Usage: `vm-image-fetch [-f] <image_name>`

Without the `-f` flag, the image only gets fetched when it isn't already in cache.

## Available AHK scripts (`ahk_scripts/` directory)

### win_terminal_hotkeys

This script adds 2 hotkeys:

- `` Ctrl+` `` - Open new Windows Terminal tab/window
in the path of active Explorer window

## License

Please see [LICENSE file](LICENSE) for details.
In short, this project is open source and you are free to modify
and use my work as long as you credit me.

---

> Jakub Kuczys &nbsp;&middot;&nbsp;
> GitHub [@Jackenmen](https://github.com/Jackenmen)
