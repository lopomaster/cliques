
require_relative 'cliques/connected_developers'
require_relative '../services/twitter_service'
require_relative '../services/github_service'

class Cliques

  def initialize file
    @file = file
  end

  private

  def read_file
    File.readlines(@file).map{ |line| line.strip }
  end

end