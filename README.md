# Young N Ambitious

YNA plans to help an infinite amount of minorities break into tech by providing professional guidance and resources through personal development, community, and open source.

## Project Description

There are so many career changers and recruiters who are trying to navigate a big pool of talent and tech companies to join. YNA screens and preps all members to become hot on the market, providing the best tech talent for recruiters to find. Individuals will no longer have to endure the job search alone and recruiters no longer have to blind recruit. YNA is a one-stop shop which aims to improve your companies profitability. Recruiting top talent for your needs.

# Mac OSX Manual Environment Set Up

## Introduction

This is a step-by-step guide for how to set up your local environment
**on a Mac**. Please note that these instructions will not work for non-Mac
users. If you're on a Windows 10 machine, see the
[Windows Subsystem for Linux setup instructions][wsl]. If you're on an older
Windows machine, refer to the [Setting up Linux Virtual Box][linux]
instructions.

The following instructions are for macOS Catalina. If you are not on Catalina
but can upgrade, we recommend doing so _after_ following the instructions below.
Additional instructions are included in the steps below for non-Catalina users.

You can check your OS version by clicking the apple menu in the top left and
clicking 'About This Mac'.

## Step By Step Instructions for Manual Installation

## ALERT - For New M1 Mac Laptops ONLY

If you are using a Mac laptop with the new M1 chip (released in late 2020), there is
an additional step required for some tools to install correctly. This step involves
creating a copy of your laptop's Terminal application and enabling it to work with
tools that aren't yet compatible with the M1 chip. Check out [this link][m1]
and follow the steps provided **before continuing**.

[m1]: https://www.notion.so/Run-x86-Apps-including-homebrew-in-the-Terminal-on-Apple-Silicon-8350b43d97de4ce690f283277e958602

### Install Xcode Command Line Tools

Open up your terminal. You can do this by going to Applications > Utilities >
Terminal, or by using the quick launch (`cmd` + `space`) and just start typing
“Terminal”.

The first tools we're going to install are the Xcode command-line tools.
[Xcode][] is a suite of development tools from Apple, including tools for
building Mac and iPhone applications. For this project, we only need the Xcode
command-line tools, as many other tools rely on them. Run the following to
install them:

```sh
xcode-select --install
```

You will be prompted to install Xcode Command-Line Tools. Agree and allow the
install to continue. You may need to provide your computer's password.

> **Important:** If the Xcode Command-Line Tools aren't installed, you may encounter
> errors later on when working with gems like `sqlite3`. To double check that everything is installed,
> rerun the `xcode-select --install` command. If everything is installed, you should see this error:
>
> ```sh
> xcode-select: error: command line tools are already installed, use "Software Update" to install updates
> ```
>
> If you receive this error, you are good to continue!

If you have recently updated your OS to Catalina 10.15.2 or are on BigSur, you may encounter some errors
related to XCode while installing Ruby and/or running Node. While working through this set up, follow any
debugging instructions provided, but if those do not work, check out the
[instructions here to make sure the Xcode Command-Line Tools are configured correctly on the new system][xcode fix]

### Install Homebrew

[Homebrew][] is a package manager for the Mac. It allows us to install a number
of things we will need. To install Homebrew, run the following:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

> **Note:** this is all one line in the terminal (even if it is broken up into
> two lines here in your browser).

You can verify that Homebrew is successfully installed by running `brew help`. If
your terminal outputs a list of `brew` commands, you're all set.

### Install Zsh

[Zsh][] is the new standard [shell][] for the macOS. To see if you're already
using Zsh, run the following:

```sh
echo $SHELL
```

If the terminal outputs `/bin/zsh`, Zsh is already installed. If something else
was output (like `/bin/bash`), run the following commands:

```sh
brew install zsh
chsh -s /bin/zsh
```

This will install Zsh and set it as the default shell.

Close your terminal and reopen. If you rerun `echo $SHELL`, the terminal should
output `/bin/zsh`.

### Install the GMP and GnuPG Packages

Before continuing further, we need to install some libraries that other tools
rely on, [GMP][] and [GnuPG][]:

```sh
brew install gmp
brew install gnupg
```

> **Note:** If you get this error: `Warning: gnupg-1.4.19 already installed`,
> GnuPG is installed, but it may not be linked properly. To fix, run:
>
> ```sh
> brew link gnupg
> ```

### Install RVM

[RVM][] is a tool that lets you run different versions of Ruby on your computer.
If one project you're working on works with Ruby version 2.3.3 and another needs
2.6.1, you can easily switch between the two versions when you switch between
projects.

The following command downloads encryption keys we need to install RVM:

```sh
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

> **Note:** If that command does not work, or you receive an error stating
> `keyserver receive failed: No route to host`, try running the following commands:
>
> ```sh
> command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
> ```
>
> ```sh
> command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
> ```

Once the encryption keys are downloaded, use the following command to download RVM:

```sh
curl -sSL https://get.rvm.io | bash
```

When RVM is installed, run `rvm reload` **or** close and reopen your terminal to make sure RVM is fully
loaded. Next, we will install the Ruby version we'll be using and set it as the default:

```sh
rvm install 2.6.1
rvm use 2.6.1 --default
```

To check that everything worked, run `rvm list`. You should see `=* ruby-2.6.1`
listed, indicating that `2.6.1` is installed and set as the default version for
Ruby. You can also run `ruby -v`, which should show that Ruby `2.6.1` is the
current version of Ruby being used.

[rvm]: https://rvm.io/

Before continuing, close and reopen your terminal and run `rvm list` one more
time to make sure everything is working.

> **Note:** If you see an error or warning when running `rvm list`, we recommend
> following the troubleshooting steps at the end of this lesson before
> continuing.

Remember, if you're on a newer version of the macOS or on an M1 machine,
you may need to do some additional set up for Xcode before RVM/Ruby will install correctly.
Check out [this resource for instructions][xcode fix]

[xcode fix]: https://medium.com/flawless-app-stories/gyp-no-xcode-or-clt-version-detected-macos-catalina-anansewaa-38b536389e8d

### Install Some Ruby Gems

Install these gems

- First, let's update our system gems by running `gem update --system`
- Install the Bundler gem with `gem install bundler`. This gem takes care of
  installing other gems you will need for projects. (mandatory)
- Install Pry with `gem install pry`. (optional)
- Install Ruby on Rails with `gem install rails` (mandatory)

## Application

This is the Rails API application maintaining the data

## Getting Started

To install this project:

- clone the project to your local terminal by running `git clone **ssh_key*` copy the ssh_key from above
- run `bundle install` to install gems/dependencies
- run `rails db:migrate` to migrate the database
- run `rails db:seed` to load seed data if present (optional)
- run `rails s` to start server

## License

- [MIT LICENSE](https://opensource.org/licenses/MIT)

## Join The YNA Community To Contribute:

- [Contributing Doc](https://github.com/Young-N-Ambitious/yna_backend/blob/main/CONTRIBUTING.md)
- [Member Application](https://docs.google.com/forms/d/e/1FAIpQLSfEHpF9H3U9yCzmUPEiac637mECOzXAqrr9AXuxuz48KUd1pQ/viewform)
