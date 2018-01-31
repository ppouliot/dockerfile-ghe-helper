#!/usr/bin/env ruby
require 'rubygems'
require 'octokit'

Octokit.configure do |c|
  c.api_endpoint = ENV.fetch('GITHUB_API')
  c.access_token = ENV.fetch('GITHUB_PERSONAL_ACCESS_TOKEN')
  c.auto_paginate = true
end
admin_client = Octokit.enterprise_admin_client
admin_client.create_organization(ENV.fetch('ORGANIZATION'), ENV.fetch('ORGANIZATION_ADMIN'))
