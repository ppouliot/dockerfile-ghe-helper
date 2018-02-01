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


ratelimit           = Octokit.ratelimit
ratelimit_remaining = Octokit.ratelimit_remaining
puts "Rate Limit Remaining: #{ratelimit_remaining} / #{ratelimit}"
puts

repos = Octokit.repositories(ENV[ORGANIZATION_ADMIN]], {sort: :pushed_at})
#cl = Octokit::Client.new(login: "komasaru", oauth_token: "token_string")
#repos = cl.repositories("komasaru", {sort: :pushed_at})

repos.each do |repo|
  puts "[ #{repo.name} ]"
  puts "\tOwner       : #{repo.owner.login}"
  puts "\tFull Name   : #{repo.full_name}"
  puts "\tDescription : #{repo.description}"
  puts "\tPrivate     : #{repo.private}"
  puts "\tLanguage    : #{repo.language}"
  puts "\tURL         : #{repo.html_url}"
  puts "\tCreated at  : #{repo.created_at}"
  puts "\tUpdated at  : #{repo.updated_at}"
  puts "\tPushed  at  : #{repo.pushed_at}"
  puts
end
