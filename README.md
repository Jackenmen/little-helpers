# little-helpers

[![Sponsor on GitHub](https://img.shields.io/github/sponsors/jack1142?logo=github)](https://github.com/sponsors/jack1142)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A few *little* scripts for things I do often so that I can type less
or make fewer clicks.\
I'm just a bit lazy...

Only tested on Windows.\
`git-` scripts are Bash scripts so they should work on Unix systems as well,
but the AutoHotkey and Batch scripts will obviously only work on Windows.

## Usage/Installation

To use the scripts in this repo, you should first clone it:

```sh
git clone https://github.com/jack1142/little-helpers
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

### git-createbranch

This script creates a branch and automatically "creates" and tracks the remote branch.

The remote branch created by the script is fake
as it isn't actually pushed to the remote
and only exists locally before first `git push`.

Usage: `git createbranch <branch_name>`

Personally, I have this command aliased to `git cb` to type even less :)

Note: TThis works with an assumption that the remote
which you want to create the branches on is called `origin`.

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
> GitHub [@jack1142](https://github.com/jack1142)
