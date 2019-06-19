require_relative 'cliques/version'

require_relative '../services/twitter_service'
require_relative '../services/github_service'
require_relative 'cliques/connected_developers'

module Cliques
  class Error < StandardError; end

  def initialize file
    @file = file
    @developers ||= read_file
  end

  def connected_developers
    ConnectedDevelopers.new developers, TwitterClient.get, GithubClient.get
  end

  private

  def read_file
    File.readlines(@file).map{ |line| line.strip }
  end

end