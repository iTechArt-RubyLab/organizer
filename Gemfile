source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

gem 'redis', '~> 4.0'

gem 'bootsnap', require: false
gem 'simple_form'

gem 'bootstrap', '~> 5.2.2'
gem 'jquery-rails'

gem 'sidekiq'

# Phone validator
gem 'phonelib', '~> 0.7.3'

# Authorization
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'avo'
gem 'geocoder'
gem 'mapkick-rb'
gem 'pagy'
gem 'pundit'
gem 'rails-i18n', '~> 7.0.0'

gem 'aws-sdk-s3'

gem 'elasticsearch'
gem 'searchkick'

gem 'simple_calendar', '~> 2.4'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  # ENV
  gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'
end

group :development do
  gem 'bullet'
  gem 'rubocop-rails', require: false
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'pundit-matchers'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
