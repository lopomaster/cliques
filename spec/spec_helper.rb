require 'dotenv'
require 'simplecov'

Dotenv.load("../.env")
SimpleCov.start

def filename filename
  File.join(File.dirname(__FILE__), 'data', filename)
end

def twitter_field user
  double(screen_name: user)
end

def github_field user
  double(login: user)
end