require 'octokit'

class GithubService
  def initialize
    # @client = Octokit::Client.new(login: ENV["GITHUB_LOGIN"], password: ENV["GITHUB_PASSWORD"])
    @client = Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
  end

  def organizations user_name
    @client.organizations(user_name).map{ |u| u.login }
  end

  def github_organizations_friendships user_a, user_b
    @github_client.organizations(user_a) & @github_client.organizations(user_b)
  end

end