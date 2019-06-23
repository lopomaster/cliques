
require 'rspec'
require_relative '../spec_helper'
require_relative '../../lib/cliques'

describe Cliques do

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

    github = double("GithubService", github_organizations_friendships: [])

    allow(github).to receive(:github_organizations_friendships) do |user_name|
      organizations[user_name]
    end

    github
  end

  let(:connection) do
    DeveloperGraph.new  ["schneems", "jhawthorn", "jonleighton", "kaspth"], twitter_client, github_client
  end

  context 'get maximal cliques' do
    it 'calculates from fake developers usernames' do
      allow_any_instance_of(Cliques).to receive(:connections).and_return(connection)
      cliques = Cliques.new filename('test_data.txt')
      expect(cliques.maximal_cliques).to eq( [["schneems", "jhawthorn", "jonleighton"], ["jhawthorn", "jonleighton", "kaspth"]])
    end
  end

  context 'read users file' do
    it 'array of usernames' do
      cliques = Cliques.new filename('test_data.txt')
      expect(cliques.developers).to eq(["schneems", "jhawthorn", "jonleighton", "kaspth"])
    end
  end

end