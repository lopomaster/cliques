require 'twitter'

class TwitterService
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def twitter_friendships developer
    @client.friends(developer) & @client.followers(developer)
    # get_friends developer
  end

  private

  def friends user_name
    @twitter_client.friends(user_name).entries.map{ |user| user.screen_name }
  end

  def followers user_name
    @twitter_client.followers(user_name).entries.map{ |user| user.screen_name }
  end

  # Mock
  # def get_friends user
  #   friends = {
  #       "schneems" => ["jhawthorn", "jonleighton"],
  #       "jhawthorn" => ["jonleighton", "kaspth"],
  #       "jonleighton" => ["kaspth"],
  #       "kaspth" => [],
  #       "lopomaster" => []
  #   }
  #   friends[user]
  # end

end