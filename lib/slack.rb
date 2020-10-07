#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'
require 'table_print'
require 'httparty'
require 'dotenv'
Dotenv.load

def print_options
  puts "Your options are: \n1. List users \n2. List channels \n3. Quit \nPlease enter the number of your choice:"
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "There are #{workspace.channels.length} channels, and #{workspace.users.length} users."

  print_options
  choice = gets.chomp.downcase

  until choice == "3" || choice == "quit"
    case choice
    when "1", "list users"
      workspace.users.each { |user| puts "#{user.real_name} - status: #{user.status_text} - status emoji: #{user.status_emoji} user ID: #{user.slack_id} user-name: #{user.name}"}
    when "2", "list channels"
      workspace.channels.each do |channel|
        puts "Channel ID:#{channel.slack_id} - Name: #{channel.name} - Topic: #{channel.topic} - Number of members: #{channel.member_count}"
      end
    else
      puts "not a valid choice, please try again"
    end
    print_options
    choice = gets.chomp
  end


  # TODO project


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME