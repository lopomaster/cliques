require 'twitter'
require 'octokit'

class ConnectedDevelopers

  attr_reader :developers

  def initialize developers, twitter_client, github_client
    @twitter_client = twitter_client
    @github_client = github_client
    @developers = developers
    @organizations = {}
    @graph ||= generate_graph
  end

  private

  def generate_graph

  end


end