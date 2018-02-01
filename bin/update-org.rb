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

client.update_org(ENV['ORGANIZATION'], { \
   :name => ENV['ORGANIZATION'],  \
   :company => ENV['ORGANIZATION'],  \
   :profile_name => ENV['ORGANIZATION'],  \
   :profile_bio => ENV['ORGANIZATION_DESCRIPTION'],  \
   :description => ENV['ORGANIZATION_DESCRIPTION'],  \
   :html_url => ENV['ORGANIZATION_URL'],  \
   :blog => ENV['ORGANIZATION_URL'],  \
   :location => ENV['ORGANIZATION_LOCATION'],  \
   :email => ENV['ORGANIZATION_EMAIL'], \
   :billing_email => ENV['ORGANIZATION_BILLING_EMAIL'], \
   :gravatar_email => ENV['ORGANIZATION_GRAVATAR_EMAIL'], \
 })
