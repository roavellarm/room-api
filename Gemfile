# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5' # or newest one

gem 'awesome_print'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'committee', '~> 3.0.3'
gem 'devise-i18n', '~>  1.8.2'
gem 'devise_token_auth', '~> 1.1.2'
gem 'http'
gem 'json_schema', '0.20.7' # DO NOT UPDATE THIS
gem 'loofah', '>= 2.3.1'
gem 'mjml-rails', '4.3.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'prmd', '~> 0.13'
gem 'puma', '~> 4.0'
gem 'pundit'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2.3'
gem 'rails-i18n', '~> 5.1.3'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.7.4'
  gem 'rspec-rails', '~> 3.7'
  gem 'rspec_junit_formatter', '~> 0.4.1'
  gem 'rubocop', '~> 0.73.0', require: false
  gem 'rubocop-rspec', '~> 1.30.0', require: false
  gem 'shoulda-matchers'
  gem 'webmock', '~> 3.6.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov', '~> 0.17.0', require: false
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
