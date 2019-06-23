
require_relative 'cliques/developer_graph'
require_relative '../services/twitter_service'
require_relative '../services/github_service'

class Cliques

  attr_reader :developers

  def initialize file
    @file = file
    @developers = read_file
  end

  def connections
    DeveloperGraph.new  @developers,TwitterService.new,GithubService.new
  end

  def maximal_cliques
    connections.maximal_cliques
  end

  private

  def read_file
    File.readlines(@file).map{ |line| line.strip }
  end

end