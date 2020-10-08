#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'
require 'table_print'
require 'httparty'
require 'dotenv'
Dotenv.load

def print_options
  puts "Your options are: \n1. List users \n2. List channels \n3. Select User \n4. Select Channel \n5. Details \n6. Quit \n\nPlease enter the number of your choice: "
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  recipient = nil
  puts "There are #{workspace.channels.length} channels, and #{workspace.users.length} users."

  print_options
  choice = gets.chomp.downcase

  until choice == "6" || choice == "quit"
    case choice
    when "1", "list users"
      workspace.users.each { |user| puts "#{user.real_name} - status: #{user.status_text} - status emoji: #{user.status_emoji} user ID: #{user.slack_id} user-name: #{user.name}"}
    when "2", "list channels"
      workspace.channels.each do |channel|
        puts "Channel ID:#{channel.slack_id} - Name: #{channel.name} - Topic: #{channel.topic} - Number of members: #{channel.member_count}"
      end
    when "3", "select user"
      puts "Please enter the id or name of the user you seek:"
      recipient = workspace.select_user(gets.chomp)
      if recipient.nil?
        puts "User not found"
      else
        puts "User selected: #{recipient.name}"
      end
    when "4", "select channel"
      puts "Please enter the id or name of the channel you seek:"
      recipient = workspace.select_channel(gets.chomp)
      if recipient.nil?
        puts "Channel not found"
      else
        puts "Channel selected: #{recipient.name}"
      end
    when "5", "details"
      if recipient.nil?
        puts "No user or channel selected"
      else
        puts workspace.show_details
      end
    else
      puts "not a valid choice, please try again"
    end
    puts ""
    print_options
    choice = gets.chomp.downcase
  end


  # TODO project


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME