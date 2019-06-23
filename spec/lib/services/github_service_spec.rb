
require 'rspec'
require_relative '../../spec_helper'
require_relative '../../lib/cliques'


describe GithubService do

  def github_field user
    double(login: user)
  end

  let(:github_service) do

    organizations = {
        "schneems" => [github_field( "rails")],
        "jhawthorn" => [github_field( "rails")],
        "jonleighton" => [github_field( "rails")],
        "kaspth" => [github_field("rails")]
    }


    github_double = double("Octokit::Client", organizations: [])
    allow(github_double).to receive(:organizations) do |user_name|
      organizations[user_name]
    end

    github_double
  end

  let(:connected_developers) do
    ConnectedDevelopers.new developers: ["user1", "user2", "user3", "user4"],
                            twitter_client: twitter_client,
                            github_client: github_client
  end



end