
require 'rspec'
require_relative '../../spec_helper'
require_relative '../../lib/cliques'


describe GithubService do

  def twitter_field user
    double(screen_name: user)
  end

  let(:twitter_service) do
    friends = {
        "user1" => [twitter_field("user2"), twitter_field("user3"), twitter_field("user5")],
        "user2" => [twitter_field("user1"), twitter_field("user3"), twitter_field("user6"), twitter_field("user4")],
        "user3" => [twitter_field("user2"), twitter_field("user4"), twitter_field("user7")],
        "user4" => [twitter_field("user2"), twitter_field("user3"), twitter_field("user1")]
    }

    followers = {
        "user1" => [twitter_field("user2"), twitter_field("user4"), twitter_field("user5")],
        "user2" => [twitter_field("user1"), twitter_field("user3"), twitter_field("user7"), twitter_field("user4")],
        "user3" => [twitter_field("user2"), twitter_field("user1"), twitter_field("user4")],
        "user4" => [twitter_field("user2"), twitter_field("user3"), twitter_field("user7")]
    }

    twitter_double = double("Twitter::REST::Client", friends: [], followers: [])

    allow(twitter_double).to receive(:friends) do |user_name|
      double(entries: friends[user_name])
    end

    allow(twitter_double).to receive(:followers) do |user_name|
      double(entries: followers[user_name])
    end

    twitter_double
  end


end