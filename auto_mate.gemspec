# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require File.expand_path('../lib/auto_mate/version', __FILE__)


Gem::Specification.new do |gem|
  gem.name = "auto_mate"
  gem.homepage = "http://github.com/wpdavenport/auto_mate"
  gem.license = "MIT"
  gem.summary = %Q{Swiss Army Knife of QA Automated testing}
  gem.description = <<-EOF
    Basically, this allows an easier way to build an automation
    framework specific to your apps.
  EOF
  gem.email = "wpdavenport@gmail.com"
  gem.authors = ["Bill Davenport"]
  gem.version = AutoMate::VERSION.dup
  gem.required_ruby_version = '>= 2.4.0'

  gem.files = Dir['{lib}/**/*']
  gem.require_paths = %w[ lib ]
  gem.default_executable = 'auto_mate'

  # gem.add_development_dependency 'bundler', '~> 1'
  # gem.add_development_dependency 'rake'

  gem.add_runtime_dependency 'bundler', '~> 1'
  gem.add_runtime_dependency 'rake', '~> 12'
  gem.add_runtime_dependency 'selenium-webdriver', '~> 3'
  gem.add_runtime_dependency 'poltergeist', '~> 1'
  gem.add_runtime_dependency 'pry', '~> 0.10'
  gem.add_runtime_dependency 'rspec', '~> 3'
  gem.add_runtime_dependency 'capybara', '~> 2'
  gem.add_runtime_dependency 'activesupport', '~> 5'
end
