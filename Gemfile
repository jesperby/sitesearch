source 'http://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'haml'
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'sprockets'
gem 'dalli'
gem 'json'

gem 'siteseeker_normalizer' #, path: '../siteseeker_normalizer'
gem 'nokogiri'

gem 'capistrano', '~> 3.0'
gem 'capistrano-bundler'
gem 'capistrano-rbenv', github: "capistrano/rbenv"

group :development do
  gem 'sinatra-reloader'
  gem 'thin'
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'rack-test'
  gem 'poltergeist'
end

group :production do
  gem 'unicorn'
#  gem 'unicorn-worker-killer'
end
