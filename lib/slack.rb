#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user.rb'
require 'httparty'
require 'dotenv'
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  puts "There is #{workspace.users.length}"


  base_url = "https://slack.com/api/users.list"
  response = HTTParty.get(base_url, query: {
      token: ENV["SLACK_TOKEN"]
  }
  )

  pp response
  # TODO project


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME