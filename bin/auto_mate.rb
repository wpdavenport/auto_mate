require 'rspec/core/rake_task'
require 'net/http'
require 'uri'
require 'json'

task :auto_mate => ENV['TASK']
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
          response = send_request(driver: driver, browser: browser, os: os, token: token)
          p response.code
          p response.body
        rescue => e
          p e.backtrace.join("\n")
        end
      end
    end
  end
  
  def send_request(driver: 'poltergeist', browser: '', os: '', token: '')
    uri = URI.parse("https://circleci.com/api/v1/project/everfi/acceptance_tests?circle-token=#{token}")
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