#!/usr/bin/env ruby
require 'rubygems'
require 'octokit'

Octokit.configure do |c|
  c.api_endpoint = ENV[ 'GITHUB_API' ]
  c.access_token =  ENV[ 'GITHUB_PERSONAL_ACCESS_TOKEN' ]

admin_client = Octokit.enterprise_admin_client
puts admin_client.license_info
end
