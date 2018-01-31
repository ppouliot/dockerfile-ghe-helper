require 'rubygems'
require 'octokit'
Octokit.configure do |c|
  c.api_endpoint = ENV[ 'GITHUB_API' ]

client = Octokit::Client.new(:access_token => ENV[ 'GITHUB_PERSONAL_ACCESS_TOKEN' ])
user = client.user
user.login

client.create_project(ENV['GH_REPOSITORY'], ENV['PROJECT_NAME'], body: ENV['PROJECT_BODY'])
puts client.projects(ENV['GH_REPOSITORY'])
end
