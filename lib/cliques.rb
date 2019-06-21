
require_relative 'cliques/developer_graph'
require_relative '../services/twitter_service'
require_relative '../services/github_service'

class Cliques

  def initialize file
    @file = file
    @developers = read_file
  end

  def connections
    DeveloperGraph.new  @developers,TwitterService.get,GithubService.new
  end

  private

  def read_file
    File.readlines(@file).map{ |line| line.strip }
  end

end