require 'octokit'

class GithubService
  def initialize
    @client = Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
  end

  def organizations user_name
    @client.organizations(user_name).map{ |u| u.login }
  end

end