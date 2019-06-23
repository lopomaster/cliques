
require 'rspec'
require_relative '../spec_helper'
require_relative '../../lib/cliques'

describe Cliques do

  twitter_friendships = {
      "schneems" => ["jhawthorn", "jonleighton"],
      "jhawthorn" => ["jonleighton", "kaspth"],
      "jonleighton" => ["kaspth"],
      "kaspth" => []
  }

  organizations = {
      "schneems" => ["rails", "github"],
      "jhawthorn" => ["rails"],
      "jonleighton" => ["rails"],
      "kaspth" => ["rails"]
  }

  let(:connection) do
    DeveloperGraph.new  ["schneems", "jhawthorn", "jonleighton", "kaspth"], TwitterService.new, GithubService.new
  end

  context 'get maximal cliques' do
    it 'calculates from fake developers usernames' do
      github_double = double("GithubService", organizations: [])
      allow(github_double).to receive(:organizations) do |user_name|
        organizations[user_name]
      end

      twitter_double = double("TwitterhubService", twitter_friendships: [])
      allow(twitter_double).to receive(:twitter_double) do |user_name|
        twitter_friendships[user_name]
      end


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