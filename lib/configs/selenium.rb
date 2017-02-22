Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, { :browser => AutoMate.browser.to_sym })
end
