#!/usr/bin/env ruby
require 'rubygems'
require 'octokit'
Octokit.configure do |c|
  c.api_endpoint = ENV[ 'GITHUB_API' ]

client = Octokit::Client.new(:access_token => ENV[ 'GITHUB_PERSONAL_ACCESS_TOKEN' ])
user = client.user
user.login

client.create_issue(ENV['GH_PROJECT'], ENV['ISSUE_NAME'], ENV['ISSUE_COMMENT'])
puts client.list_issues(ENV['GH_PROJECT'])
end
