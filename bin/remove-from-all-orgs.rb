
#!/usr/bin/env ruby
require 'rubygems'
require 'octokit'

Octokit.configure do |c|
  c.api_endpoint = ENV['GITHUB_API']
  c.access_token = ENV['GITHUB_PERSONAL_ACCESS_TOKEN']
end

user = Octokit.user.login

Octokit.organizations.each do |org|
  Octokit.remove_organization_member org.login, user
end
