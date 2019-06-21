require 'octokit'

class GithubService
  def self.get
    Octokit::Client.new(access_token: ENV["GITHUB_ACCESS_TOKEN"])
  end

  def organizations client, user_name
    client.organizations(user_name).map{ |u| u.login }
  end

end