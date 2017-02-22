Capybara.register_driver :poltergeist do |app|
  options = {
    phantomjs_options: [
      '--ssl-protocol=any',
      '--load-images=false',
      '--ignore-ssl-errors=true']
    }
  Capybara::Poltergeist::Driver.new app, options
end
