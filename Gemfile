# Gemfile
source "https://rubygems.org"

group :development, :test do
  gem 'rspec'
  gem 'simplecov', require: false
end

group :development, :test, :production do
  gem 'rgl'
  gem 'concurrent-ruby', require: 'concurrent'
  gem 'twitter'
  gem 'octokit', '~> 4.0'
  gem 'dotenv'
end
