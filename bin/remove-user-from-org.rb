#!/usr/bin/env ruby
require 'rubygems'
require 'octokit'

Octokit.configure do |c|
  c.api_endpoint = ENV['GITHUB_API']
  c.access_token = ENV['GITHUB_PERSONAL_ACCESS_TOKEN']
end
admin_client = Octokit.enterprise_admin_client
admin_client.remove_organization_member(ENV['ORGANIZATION'], ENV['ORGANIZATION_USER'])
