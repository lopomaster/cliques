
require 'rspec'
require_relative '../../spec_helper'
require_relative '../../../lib/cliques'

describe DeveloperGraph do

  let(:twitter_client) do
    friends_and_followers = {
        "schneems" => ["jhawthorn", "jonleighton"],
        "jhawthorn" => ["jonleighton", "kaspth"],
        "jonleighton" => ["kaspth"],
        "kaspth" => []
    }

    twitter_double = double("TwitterService", twitter_friendships: [])

    allow(twitter_double).to receive(:twitter_friendships) do |user_name|
      friends_and_followers[user_name]
    end

    twitter_double
  end

  let(:github_client) do
    organizations = {
        "schneems" => ["rails", "github"],
        "jhawthorn" => ["rails"],
        "jonleighton" => ["rails"],
        "kaspth" => ["rails"]
    }

    github = double("GithubService", organizations: [])

    allow(github).to receive(:organizations) do |user_name|
      organizations[user_name]
    end

    github
  end

  let(:connection) do
    DeveloperGraph.new  ["schneems", "jhawthorn", "jonleighton", "kaspth"], twitter_client, github_client
  end

  context 'build graph' do
    it 'build graph' do
      developer_graph = connection
      developer_graph.graph
      expect(developer_graph.graph.adjacent_vertices("schneems")).to eq(["jhawthorn", "jonleighton"])
      expect(developer_graph.graph.adjacent_vertices("jhawthorn")).to eq(["schneems", "jonleighton", "kaspth"])
      expect(developer_graph.graph.adjacent_vertices("jonleighton")).to eq(["schneems", "jhawthorn", "kaspth"])
      expect(developer_graph.graph.adjacent_vertices("kaspth")).to eq(["jhawthorn", "jonleighton"])

    end

    it 'build an empty graph' do
      connection = DeveloperGraph.new  [], twitter_client, github_client
      developer_graph = connection
      developer_graph.graph
      expect(developer_graph.graph.vertices).to eq ([])
    end
  end

  context 'maximal cliques' do

    it 'maximal cliques' do
      connection = DeveloperGraph.new  [], twitter_client, github_client
      expect(connection.maximal_cliques).to eq ([])
    end

    it 'maximal cliques' do
      connection = DeveloperGraph.new  ["schneems", "jhawthorn", "jonleighton", "kaspth"], twitter_client, github_client
      expect(connection.maximal_cliques).to eq ([["schneems", "jhawthorn", "jonleighton"], ["jhawthorn", "jonleighton", "kaspth"]])
    end

  end
end

