# AutoMate

AutoMate is a framework that can be highly customized for QA automation. 

### Dependencies

  * Ruby > 2.4.0
  * For OSX - Install brew package manager

## Installation

In your Gemfile:
```bash
gem 'auto_mate'
```

### Get Up and Running

##### Tutorial

- mkdir my_automation
- cd my_automation
- touch Gemfile
- vi Gemfile and add ```bash gem 'auto_mate'```
- check ruby version and update if necessary (* see Bundle below)
- gem install bundler
- bundle install

##Automation Setup

###  Homebrew Packages

To get AutoMate setup you'll need some packages to get you started.

`brew install rbenv ruby-build chromedriver phantomjs`

** Make sure that Phantomjs 2.1.1 or higher is installed.


### AutoMate Modes

#### Headless (default):
This will run using the phantomjs headless browser. No browser window will display.

```bash
rspec
```

#### With a Browser:
* Use different browsers with Environmental variables

```bash
export BROWSER_NAME=''
export DRIVER=selenium
BROWSER_NAME=chrome 
rspec
```

Supported Browsers:
* chrome
* firefox
* safari

### Data Files and Switching Environments
By default, AutoMate uses fixtures. With fixutres, you can test automation against different enviroment. Each environment should have its own data files. An example fixture is supplied for you.
You can set the fixtures in a constant in your spec_helper.rb file.

```bash
FIXTURES = AutoMate.fixtures
```

Structure:
```bash
- spec
  |- data
     |- dev.yml
```

Example: dev.yml
```bash
---
url: 'http://www.example.com'

test_account:
  user_name: foo
  passwoard: bar
```
##### Fixture Requirements
• Each fixture should be named for the enviroment you want to test. Naming is up to you, just make sure that the yaml file is named after the environment
• Must have a URL that you want to test against in the fixture

This will setup AutoMate to run the test suite against a dev environment using data from spec/data/dev.yml.

```bash
export ENVIRONMENT='dev'
ENVIRONMENT=dev rspec
```

##### Copyright

Copyright (c) 2017 Bill Davenport. See LICENSE.txt for
further details.

