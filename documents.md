DOCS:

### Upgrade homebrew
Sometimes you need to update homebrew. If there is a better way let me know. this will remove all of your apps you have installed with brew
Brew you do this, get a list of what you have and copy it somewhere.  `brew list`

`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"`



### Bundle

Make sure you have Ruby installed.

```bash
cat .ruby-version
> 2.4.0
```

Otherwise, install the correct ruby version, install bundler
```bash
rbenv install 2.4.0
rbenv rehash
gem install bundler
bundle install
```


### RBENV with .ruby-version
Set your ruby version in your app

create a file called .ruby-version
open the file and put the ruby verion:
2.4.0

to test:
`ruby -v`
2.4.0

### Required Tools

  * Homebrew: Mac OS X package manager
    * `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
  * Safari WebDriver: Download and double click do install.
    * http://selenium-release.storage.googleapis.com/index.html?path=2.48/
  * Firefox: https://www.mozilla.org/en-US/firefox/new
  * Chrome: https://www.google.com/chrome/
