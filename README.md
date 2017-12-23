# Mac OS X Dev Setup

This document describes how I set up my developer environment on a new MacBook or iMac. We will set up [Node](http://nodejs.org/) (JavaScript), [Python](http://www.python.org/), and [Ruby](http://www.ruby-lang.org/) environments, mainly for JavaScript and Python development. Even if you don't program in all three, it is good to have them as many command-line tools use one of them. As you read  and follow these steps, feel free to send me any feedback or comments you may have.

The steps below were tested on **OS X Mountain Lion**.

Original credits go to nicolashery [on Twitter](https://twitter.com/nicolahery)

- [System update](#system-update)
- [System preferences](#system-preferences)
- [Google Chrome](#google-chrome)
- [XCode](#xcode)
- [iTerm2](#iterm2)
- [Homebrew](#homebrew)
- [Oh-my-ZSH Shell](#oh-my-zsh)
- [iTerm2](#iterm2)
- [Sublime Text](#sublime-text)
- [Git](#git)
- [Vim](#vim)
- [Python](#python)
- [Node.js](#nodejs)
- [Projects folder](#projects-folder)
- [Apps](#apps)

## System update
First thing you need to do, on any OS actually, is update the system! For that: **Apple Icon > Software Update...**

## System preferences
If this is a new computer, there are a couple tweaks I like to make to the System Preferences. Feel free to follow these, or to ignore them, depending on your personal preferences.

In **Apple Icon > System Preferences**:
- Trackpad > Tap to click
- Keyboard > Key Repeat > Fast (all the way to the right)
- Keyboard > Delay Until Repeat > Short (all the way to the right)
- Dock > Automatically hide and show the Dock

## Google Chrome
Download from [www.google.com/chrome](https://www.google.com/intl/en/chrome/browser/).

## Xcode
    $ xcode-select --install

## iTerm2
Since we're going to be spending a lot of time in the command-line, let's install a better terminal than the default one. Download and install [iTerm2](http://www.iterm2.com/) (the newest version, even if it says "beta release").

In **Finder**, drag and drop the **iTerm** Application file into the **Applications** folder.

You can now launch iTerm, through the **Launchpad** for instance.

Let's just quickly change some preferences. In **iTerm > Preferences...**, under the tab **General**, uncheck **Confirm closing multiple sessions** and **Confirm "Quit iTerm2 (Cmd+Q)" command** under the section **Closing**.

In the tab **Profiles**, create a new one with the "+" icon, and rename it to your first name for example. Then, select **Other Actions... > Set as Default**. Finally, under the section **Window**, change the size to something better, like **Columns: 125** and **Rows: 35**.

When done, hit the red "X" in the upper left (saving is automatic in OS X preference panes). Close the window and open a new one to see the size change.

### iTerm Visor

Open the iTerm2 preferences.

Under the Keys tab select only the first 2 checkboxes under Hotkey and change the Hotkey itself to ^\`.

Under the Appearance tab uncheck Hide tab bar when there is only one tab so you can easily drag in and out tabs from the visor.

Under the Profiles tab tweak the Hotkey Window profile to your liking. I use minimal transparency for better readability and Full-Width Left of Screen style so it doesn’t cover SublimeText, which I normally have on the left-side.

Now wherever and whenever you need the console, just press ^\` to open the visor or bring it to the front if it already was. By leaving the 3rd checkbox unselected I’ve set it not to hide when it looses focus so I can keep an eye on logs while I make changes in SublimeText that cause hot-reloads via TiShadow or LiveView.

[Help Video](https://www.youtube.com/watch?v=ETskRNFeuGM).

## Homebrew

Package managers make it so much easier to install and update applications (for Operating Systems) or libraries (for programming languages). The most popular one for OS X is [Homebrew](http://brew.sh/).

### Install

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

One thing we need to do is tell the system to use programs installed by Hombrew (in `/usr/local/bin`) rather than the OS default if it exists. We do this by adding `/usr/local/bin` to your `$PATH` environment variable:

    $ echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

Open a new terminal tab with **Cmd+T** (you should also close the old one), then run the following command to make sure everything works:

    $ brew doctor
    
### Usage

To install a package (or **Formula** in Homebrew vocabulary) simply type:

    $ brew install <formula>
        
To update Homebrew's directory of formulae, run:

    $ brew update
    
**Note**: I've seen that command fail sometimes because of a bug. If that ever happens, run the following (when you have Git installed):

    $ cd /usr/local
    $ git fetch origin
    $ git reset --hard origin/master

To see if any of your packages need to be updated:

    $ brew outdated
    
To update a package:

    $ brew upgrade <formula>
        
Homebrew keeps older versions of packages installed, in case you want to roll back. That rarely is necessary, so you can do some cleanup to get rid of those old versions:

    $ brew cleanup

To see what you have installed (with their version numbers):

    $ brew list --versions

## Oh-my-ZSH

Install zsh and zsh completions using homebrew:

    brew install zsh zsh-completions
    
Install oh-my-zsh on top of zsh to getting additional functionality

    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
    
if still in the default shell, change default shell to zsh manually

chsh -s /bin/zsh

edit the .zshrc by opening the file in a text editor

    ZSH_THEME="af-magic"
    # Use sublimetext for editing config files
    alias zshconfig="subl ~/.zshrc"
    alias envconfig="subl ~/Projects/config/env.sh"
    plugins=(git sublime zsh-syntax-highlighting brew colored-man pip python virtualenv colorize github osx jira git-flow git-extras npm node theme web-search battery docker docker-compose)
    # Add env.sh
    . ~/Projects/config/env.sh
    
env.sh

    #!/bin/zsh
    # PATH
    export PATH="/usr/local/share/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    export EDITOR='subl -w'
    # export PYTHONPATH=$PYTHONPATH
    # export MANPATH="/usr/local/man:$MANPATH"
    # Virtual Environment
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Projects
    source /usr/local/bin/virtualenvwrapper.sh
    # Owner
    export USER_NAME="YOUR NAME"
    eval "$(rbenv init -)"
    # FileSearch
    function f() { find . -iname "*$1*" ${@:2} }
    function r() { grep "$1" ${@:2} -R . }
    # mkdir and cd
    function mkcd() { mkdir -p "$@" && cd "$_"; }
    # Aliases
    alias cppcompile='c++ -std=c++11 -stdlib=libc++'

## Git

What's a developer without [Git](http://git-scm.com/)? To install, simply run:

    $ brew install git
    
When done, to test that it installed fine you can run:

    $ git --version
    
And `$ which git` should output `/usr/local/bin/git`.

Let's set up some basic configuration. Download the [.gitconfig](https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.gitconfig) file to your home directory:

    $ cd ~
    $ curl -O https://raw.githubusercontent.com/nicolashery/mac-dev-setup/master/.gitconfig

It will add some color to the `status`, `branch`, and `diff` Git commands, as well as a couple aliases. Feel free to take a look at the contents of the file, and add to it to your liking.

Next, we'll define your Git user (should be the same name and email you use for [GitHub](https://github.com/) and [Heroku](http://www.heroku.com/)):

    $ git config --global user.name "Your Name Here"
    $ git config --global user.email "your_email@youremail.com"

They will get added to your `.gitconfig` file.

To push code to your GitHub repositories, we're going to use the recommended HTTPS method (versus SSH). So you don't have to type your username and password everytime, let's enable Git password caching as described [here](https://help.github.com/articles/set-up-git):

    $ git config --global credential.helper osxkeychain
    
**Note**: On a Mac, it is important to remember to add `.DS_Store` (a hidden OS X system file that's put in folders) to your `.gitignore` files. You can take a look at this repository's [.gitignore](https://github.com/nicolashery/mac-dev-setup/blob/master/.gitignore) file for inspiration.
    
## Atom Editor

[Download it](https://atom.io/download/mac)

## SourceCodePro Font

I really like the SourceCodePro font for coding. Let's install it now.

[Download it](http://www.fontsquirrel.com/fonts/source-code-pro), then open it and double click to install.

## Vim

Vim's default settings aren't great, and you could spend a lot of time tweaking your configuration (the `.vimrc` file). But if you're like me and just use Vim occasionally, you'll be happy to know that [Tim Pope](https://github.com/tpope) has put together some sensible defaults to quickly get started.

First, install [pathogen.vim](https://github.com/tpope/vim-pathogen) by running:

    $ mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

Then create a file `~/.vimrc` (you can use `$ subl ~/.vimrc`), and paste in the following:

    execute pathogen#infect()
    syntax on
    filetype plugin indent on

And finally, install the Vim "sensible defaults" by running:

    $ cd ~/.vim/bundle
    $ git clone git://github.com/tpope/vim-sensible.git

With that, Vim will look a lot better next time you open it!

## Python

OS X, like Linux, ships with [Python](http://python.org/) already installed. But you don't want to mess with the system Python (some system tools rely on it, etc.), so we'll install our own version with Homebrew. It will also allow us to get the very latest version of Python 2.7.

The following command will install Python 2.7 and any dependencies required (it can take a few minutes to build everything):

    $ brew install python
    
When finished, you should get a summary in the terminal. Running `$ which python` should output `/usr/local/bin/python`.

It also installed [Pip]() (and its dependency [Distribute]()), which is the package manager for Python. Let's upgrade them both:

    $ pip install --upgrade distribute
    $ pip install --upgrade pip
    
Executable scripts from Python packages you install will be put in `/usr/local/share/python`, so let's add it to the `$PATH`. To do so, we'll create a `.path` text file in the home directory (I've already set up `.zshrc` to call this file):

    $ cd ~
    $ atom .path
    
And add these lines to `.path`:

```bash
PATH=/usr/local/share/python:$PATH
export PATH
```
    
Save the file and open a new terminal to take the new `$PATH` into account (everytime you open a terminal, `.zshrc` gets loaded).

## Virtualenv

[Virtualenv](http://www.virtualenv.org/) is a tool that creates an isolated Python environment for each of your projects. For a particular project, instead of installing required packages globally, it is best to install them in an isolated folder in the project (say a folder named `venv`), that will be managed by virtualenv.

The advantage is that different projects might require different versions of packages, and it would be hard to manage that if you install packages globally. It also allows you to keep your global `/usr/local/lib/python2.7/site-packages` folder clean, containing only critical or big packages that you always need (like IPython, Numpy).

### Install

To install virtualenv, simply run:

    $ pip install virtualenv

### Usage

Let's say you have a project in a directory called `myproject`. To set up virtualenv for that project:

    $ cd myproject/
    $ virtualenv venv --distribute
    
If you want your virtualenv to also inherit globally installed packages (like IPython or Numpy mentioned above), use:

    $ virtualenv venv --distribute --system-site-packages

These commands create a `venv` subdirectory in your project where everything is installed. You need to **activate** it first though (in every terminal where you are working on your project):

    $ source venv/bin/activate
    
You should see a `(venv)` appear at the beginning of your terminal prompt indicating that you are working inside the virtualenv. Now when you install something:

    $ pip install <package>

It will get installed in the `venv` folder, and not conflict with other projects.

**Important**: Remember to add `venv` to your project's `.gitignore` file so you don't include all of that in your source code!

As mentioned earlier, I like to install big packages (like Numpy), or packages I always use (like IPython) globally. All the rest I install in a virtualenv.

## Node.js

Install [Node.js](http://nodejs.org/) with Homebrew:

    $ brew update
    $ brew install node
    
The formula also installs the [npm](https://npmjs.org/) package manager. However, as suggested by the Homebrew output, we need to add `/usr/local/share/npm/bin` to our path so that npm-installed modules with executables will have them picked up.

To do so, add this line to your `~/.path` file, before the `export PATH` line:

```bash
PATH=/usr/local/share/npm/bin:$PATH
```
        
Open a new terminal for the `$PATH` changes to take effect.

We also need to tell npm where to find the Xcode Command Line Tools, by running:

    $ sudo xcode-select -switch /usr/bin

(If Xcode Command Line Tools were installed by Xcode, try instead:)

    $ sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

## Projects folder

This really depends on how you want to organize your files, but I like to put all my version-controlled projects in `~/git`. Other documents I may have, or things not yet under version control, I like to put in `~/dev` (And put it under a cloud backup).

## Apps

Here is a quick list of some apps I use, and that you might find useful as well:

- [Google Drive](https://drive.google.com/): File syncing to the cloud! I use Google Docs a lot to collaborate with others (edit a document with multiple people in real-time!), and sometimes upload other non-Google documents (pictures, etc.), so the app comes in handy for that.
- [Simplenote](http://simplenote.com/) because I only take text notes, and I got tired of Evernote putting extra spaces between paragraphs when I copy & pasted into other applications. Simplenote is so much better for text notes (and it supports Markdown!). Another alternative is [Google Keep](https://www.google.com/keep)
- [BetterTouchTool](http://www.boastr.net/downloads/): Don't waste time resizing and moving your windows. BetterTouchTool makes this very easy.
