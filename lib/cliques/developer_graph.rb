require_relative '../../services/app_logger'
require 'concurrent'
require 'twitter'
require 'octokit'
require 'rgl/adjacency'
require_relative 'maximal_cliques'

class DeveloperGraph

  attr_reader :developers, :graph

  def initialize developers, twitter_client, github_client
    @twitter_client = twitter_client
    @github_client = github_client
    @developers = developers
  end

  def graph
    @graph ||= build_graph
  end

  def maximal_cliques
    max_cliques = MaximalCliques.new( graph)
    max_cliques.max_cliques
  end

  private

  def build_graph
    excluded = []
    developers_graph = RGL::AdjacencyGraph.new

    promises = @developers.map do |current_developer|
      excluded << current_developer
      graph_by_developer developers_graph, current_developer, excluded.clone
    end

    Concurrent::Promise.all?(*promises).execute.wait!
    developers_graph
  end

  def graph_by_developer developers_graph, current_developer, excluded
    AppLogger.debug "USER: #{current_developer}"
    remainig_devs = @developers - excluded
    Concurrent::Promise.new {
      github_graph developers_graph, current_developer, remainig_devs
    }.then { |developers_graph|
      twitter_graph developers_graph, current_developer, remainig_devs
    }
  end

  def github_graph developers_graph, current_developer, remaining_devs
    remaining_devs.each do |related_developer|

      if @github_client.github_organizations_friendships(current_developer, related_developer).any?
        # create a bidirectional node
        developers_graph.add_edge current_developer, related_developer
      else
        developers_graph.remove_edge current_developer, related_developer
      end
    end
    developers_graph
  end


  def twitter_graph developers_graph, current_developer, remaining_devs
    remaining_devs.each do |related_developer|
      if @twitter_client.twitter_friendships(current_developer).include? related_developer
        # create a bidirectional node
        developers_graph.add_edge current_developer, related_developer
      else
        developers_graph.remove_edge current_developer, related_developer
      end
    end
    developers_graph
  end

end