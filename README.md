# git-helpers

[![Subscribe on Patreon](https://img.shields.io/badge/Support%20me%20on-Patreon-orange.svg?logo=patreon)](https://www.patreon.com/Jackenmen)
[![License: Apache-2.0](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

A few small git scripts for things I do often so that I can type less.
I'm just a bit lazy...

Only tested on Windows but these are Bash scripts
so they should run just fine on Unix systems.

## Usage/Installation

To use the scripts in this repo, you should first clone it:

```sh
git clone https://github.com/jack1142/git-helpers
```

After you have the repository cloned into a folder, you just need to
add the `REPO_PATH/bin` folder to your `PATH` so that the scripts in it
can be detected by git and auto-added into its namespace.

## Available scripts

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

This can optionally be passed with a branch.

Usage: `git checkoutpr <pr_number> [branch]`

Personally, I have this command aliased to `git copr` to type even less :)

Note: only works on GitHub and other services who provide merge commit refs
in a format of: `pull/PR_NUMBER/merge`

## License

Please see [LICENSE file](LICENSE) for details.
In short, this project is open source and you are free to modify
and use my work as long as you credit me.

---

> Jakub Kuczys &nbsp;&middot;&nbsp;
> GitHub [@jack1142](https://github.com/jack1142)
