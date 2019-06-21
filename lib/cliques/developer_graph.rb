require_relative '../../services/app_logger'
require 'twitter'
require 'octokit'
require 'rgl/adjacency'

class DeveloperGraph

  attr_reader :developers

  def initialize developers, twitter_client, github_client
    @twitter_client = twitter_client
    @github_client = github_client
    @developers = developers
    @graph = build_graph
  end

  private

  def build_graph
    excluded = []
    developers_graph = RGL::DirectedAdjacencyGraph.new

    promises = @developers.map do |current_developer|
      excluded << current_developer
      graph_by_developer developers_graph, current_developer, excluded
    end



    # Concurrent::Promise.all?(*promises).execute.wait!
    developers_graph
  end


  def graph_by_developer developers_graph, current_developer, excluded
    AppLogger.debug "GITHUB USER: #{current_developer}"
    AppLogger.debug "ORGANIZATIONS: #{@github_client.organizations(current_developer)}"

    graph_by_github_organization developers_graph, current_developer, @developers - excluded

    graph_by_twitter_organization( developers_graph, current_developer, @developers - excluded) if @github_client.organizations(current_developer).any?

    developers_graph

  end

  def graph_by_github_organization developers_graph, current_developer, remaining_devs
    AppLogger.debug "REMAINING DEVS: #{remaining_devs}"
    remaining_devs.each do |related_developer|

      # if (@github_client.organizations(current_developer) & @github_client.organizations(related_developer)).any?
      #   # create a bidirectional node
      #   developers_graph.add_edge current_developer, related_developer
      # end
    end
    developers_graph
  end


  def graph_by_twitter_organization developers_graph, current_developer, remaining_devs

    AppLogger.debug "REMAINING DEVS: #{remaining_devs}"
    remaining_devs.each do |related_developer|

      if ( @twitter_client.twitter_friendships(current_developer) )#&& developers_graph.adjacent_vertices(current_developer)).any?
        # create a bidirectional node
        developers_graph.add_edge current_developer, related_developer
      else
        developers_graph.delete_edge current_developer, related_developer
      end
    end
    developers_graph

  end

end