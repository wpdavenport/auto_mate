Capybara.register_driver :remote do |app|
  capabilities = {
    os: AutoMate.os_name,
    os_version: AutoMate.os_version,
    browser:  Automate.browser,
    browser_version: Automate.browser_version
    :"browserstack.debug" => "true",
    project: AutoMate.project_name,
    name: Automate.product_name,
  }

  Capybara::Selenium::Driver.new(app, {
    :browser => :remote,
    :url => "https://#{Automate.browserstack_username}:#{Automate.browserstack_key}@hub-cloud.browserstack.com/wd/hub",
    :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.new(capabilities)
    })
end


require 'rspec/core/rake_task'
require 'net/http'
require 'uri'
require 'json'

task :default => ENV['TASK']
namespace auto_mate do
  desc "Run Browser tests on Browserstack ENV['BROWSERS'] is required. See Readme"
  task :remote do
    if ENV['BROWSERS'].nil? || ENV['BROWSERS'].empty?
      send_request
    else
      driver = 'remote'
      browsers = ENV['BROWSERS'].split
      os = browsers.delete_at(-1)

      browsers.each do |browser|
        begin
          response = send_request(driver: driver, browser: browser, os: os)
          p response.code
          p response.body
        rescue => e
          p e.backtrace.join("\n")
        end
      end
    end
  end
  
  def send_request(driver: 'poltergeist', browser: '', os: '')
    uri = URI.parse("https://circleci.com/api/v1/project/everfi/acceptance_tests?circle-token=#{ENV['CIRCLE_TOKEN']}")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump({
        'build_parameters' => {
          'OS' => name(os),
          'OS_VERSION' => version(os),
          'BROWSER_NAME' => name(browser),
          'BROWSER_VERSION' => version(browser),
          'DRIVER' => driver,
          'BROWSERSTACK_USERNAME' => ENV['BROWSERSTACK_USERNAME'],
          'BROWSERSTACK_KEY' => ENV['BROWSERSTACK_KEY'],
          'ENVIRONMENT' => ENV['ENVIRONMENT']
        }
    })
    p "Sending parameters to CircleCI: #{request.body}"
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end
  end

  def name(param)
    param.match(/\D+/).to_s
  end
  
  def version(param)
    (param.downcase == 'osx') ? 'El Capitan' : param.match(/\d+/).to_s
  end
end