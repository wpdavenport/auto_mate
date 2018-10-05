# encoding: utf-8

require 'pry'
require 'yaml'
require 'rspec'
require 'auto_mate'
require 'capybara/dsl'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'capybara/poltergeist'
require 'active_support/core_ext/hash/indifferent_access'


module AutoMate

   class << self

     # FIXTURES
     attr_reader   :fixtures_filename
     attr_accessor :environment, :browser, :use_fixtures

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
     # [browser] = String/nil               Sets the browser that will open if using Selenium
     # [use_fixtures] = Boolean            Default is true
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
       @browser = _browser
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
