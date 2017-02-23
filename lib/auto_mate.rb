# encoding: utf-8
require 'erb'
require 'pry'
require 'yaml'
require 'rake'
require 'rspec'
require 'auto_mate'
require 'capybara/dsl'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'capybara/poltergeist'
require 'active_support/core_ext/hash/indifferent_access'


require 'configs/remote'
require 'configs/poltergeist'
require 'configs/selenium'

module AutoMate

  class << self

    # FIXTURES
    attr_reader   :fixtures_filename
    attr_accessor :environment, :browser, :use_fixtures, :os_name, :os_version, :browser_version,
                 :project_name, :product_name, :api_user_name, :api_key

    # Configure AutoMate to suit your needs.
    #
    #     AutoMate.configure do |config|
    #       config.browser     = :chrome
    #       config.environment = :dev
    #     end
    #
    # === Configurable options
    #
    # [environment = String/nil]           Sets the environment to be tested. Also, yaml named for environment (development.yml) will be loaded from spec/data. FIXTURES constant will hold data
    # [browser]                   = String/nil   Sets the browser that will open if using Selenium
    # [use_fixtures]              = Boolean      Default is true
    # [os_name]                   = String/nil   Name for OS (windows, osx, linux)
    # [os_version]                = String/nil   Specific version of OS. Check OS defaults when version is nil
    # [browser_version]           = String/nil   Default is true
    # [project_name]              = String/nil   Typically it's the type of automation (smoketest, regression). Default: "Automate Project Automation"
    # [product_name]              = String/nil   Name of app you are testing. Default: "Automate Product Automation"
    # [browserstack_browsers_and_os] = String/nil   When you want to run your tests using browserstack.
    #                                               EXAMPLE: 'BROWSERS='ie8 chrome52 firefox windows10'
    #                                               REQUIRED: Space separated list of Browsers for Browserstack. Version is not required
    #                                               REQUIRED: OS is always at the end of the list. Version is not required
    # [browserstack_username]     = String/nil   Account used for API access
    # [browserstack_key]          = String/nil   API Key provided for API acccess
    # [api_token]                 = String/nil   API token for continuous integration server
    # 

    def configure
     yield self
    end

    def environment=(_environment)
      @environment = _environment
    end

    def fixtures
      if @use_fixtures && @environment.nil?
        puts "Missing Environment for loading fixtures. Please update Yaml file"
        exit 1
      end
      @fixtures = ActiveSupport::HashWithIndifferentAccess.new YAML.load(ERB.new(File.read(fixtures_file)).result)
    end

    def use_fixtures=(_use_fixtures=true)
      @use_fixtures = _use_fixtures
    end

    def browser=(_browser)
      @browser = _browser.to_s
    end

    def browser_version=(_browser_version)
      @browser_version = _browser_version.to_s
    end

    def os_name=(_os_name)
      @os_name = _os_name.to_s
    end

    def os_version=(_os_version)
      @os_version = _os_version.to_s
    end

    def project_name=(_project_name)
      @project_name = _project_name || "Automate Project Automation"
    end

    def product_name=(_product_name)
      @product_name = _product_name || "AutoMate Product Automation"
    end

    def browserstack_browsers_and_os=(_browserstack_browsers_and_os)
      @browserstack_browsers_and_os = _browserstack_browsers_and_os.to_s.to_s
    end

    def browserstack_username=(_browserstack_username)
      @browserstack_username = _browserstack_username.to_s
    end

    def browserstack_key=(_browserstack_key)
      @browserstack_key = _browserstack_key.to_s
    end

    def api_token=(_api_token)
      @api_token = _api_token.to_s
    end

    private

    def fixtures_file
      File.join('./', 'spec', 'data', "#{@environment.to_s}.yml")
    end
  end
end

## Slow Down Selenium Tests when test are run in the browser
## Otherwise it's too fast to watch
module ::Selenium::WebDriver::Remote
  class Bridge
    def execute(*args)
      res = raw_execute(*args)['value']
      sleep 0.1
      res
    end
  end
end
