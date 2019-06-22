
require_relative 'cliques/developer_graph'
require_relative '../services/twitter_service'
require_relative '../services/github_service'

class Cliques

  def initialize file
    @file = file
    @developers = read_file
  end

  def connections
    @connections = DeveloperGraph.new  @developers,TwitterService.new,GithubService.new
  end

  def maximal_cliques

  end

  private

  def read_file
    File.readlines(@file).map{ |line| line.strip }
  end

end