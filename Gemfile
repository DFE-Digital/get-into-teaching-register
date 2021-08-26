source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(".ruby-version").chomp

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1.3"

# Use postgres as the database for Active Record
gem "pg"

# Use Puma as the app server
gem "puma", "~> 5.3"

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker"

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

# Manage multiple processes i.e. web server and webpack
gem "foreman"

# Canonical meta tag
gem "canonical-rails"

gem "govuk_design_system_formbuilder"

gem "secure_headers"

gem "validates_timeliness"

gem "dotenv-rails"

gem "rack-attack"

# redis for session store
gem "redis"

gem "prometheus-client"

# api client
gem "get_into_teaching_api_client_faraday", github: "DFE-Digital/get-into-teaching-api-ruby-client", require: "api/client"

gem "sentry-rails"
gem "sentry-ruby"

# Ignore cloudfront IPs when getting customer IP address
gem "actionpack-cloudfront"

gem "invisible_captcha"

gem "iso_country_codes"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]

  # GOV.UK interpretation of rubocop for linting Ruby
  gem "rubocop-govuk", require: false
  gem "scss_lint-govuk"

  # Static security scanner
  gem "brakeman", require: false

  # Debugging
  gem "pry-byebug"

  # Testing framework
  gem "rspec-rails", "~> 5.0.2"
  gem "rspec-sonarqube-formatter", "~> 1.5"
  gem "simplecov", "~> 0.21.2"
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", "~> 3.35", ">= 3.35.3"
  # Factory builder
  gem "factory_bot_rails"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.7"
  gem "web-console", ">= 3.3.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "shoulda-matchers"
  gem "vcr"
  gem "webdrivers", "~> 4.6"
  # Used when VCR is turned off to block HTTP requests.
  gem "webmock"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :rolling, :preprod, :userresearch, :production, :pagespeed do
  # loading the Gem monkey patches rails logger
  # only load in prod-like environments when we actually need it
  gem "amazing_print"
  gem "rails_semantic_logger", ">= 4.5.1"
end
