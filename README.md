# Harmonics Helper

This is tools to help learning 4 parts harmonics who use score making application.
Harmonics contains many prohibition and it's difficult to find prohibitations for learner.
This tool check prohibitition or some important things from MusicXML files - most of the score making application describe score as this format internal and user can export MusicXML easily-

---

### Requirements

Ruby is required
Please install ruby

And support score is four parts score only

---

#### How To Install Ruby

- for windows

Download installer and install Ruby

[Ruby Instller download page](https://rubyinstaller.org/)

Set the pathy

[How to set path](https://www.computerhope.com/issues/ch000549.htm)

Check install is finished?

Use command prompt or Power shell etc..

If not, please reboot

```sh
ruby -v
```

Install bundler

```sh
gem install bundler
```

- for Mac

ruby is already installed, but it may be older version

If not move, please update version


Install homebrew

[Homebrew](https://brew.sh/)

Install rbenv and update Ruby version

```sh
brew install rbenv ruby-build
rbenv install 2.5.0
rbenv global 2.5.0
```

Confirm update version

```sh
ruby -v
```

Install bundler

```sh
gem install bundler
```

- for linux

Good luck(maybe easy to linux user)

---

### Usage

set xml files under files directory and execute

```sh
bundle exec ruby exe/main.rb [filename]
```