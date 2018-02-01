#!/usr/bin/env ruby
require 'rubygems'
require 'octokit'
Octokit.configure do |c|
  c.api_endpoint = ENV[ 'GITHUB_API' ]
  c.access_token = ENV[ 'GITHUB_PERSONAL_ACCESS_TOKEN' ]
end
client = Octokit::Client.new
user = client.user
user.login

puts user.rels[:gists].href
puts Octokit.gists
