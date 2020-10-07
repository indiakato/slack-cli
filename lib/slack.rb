#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'
require 'httparty'
require 'dotenv'
Dotenv.load

def print_options
  puts "Your option are: \n1. List users \n2. List channels \n3. Quit \nPlease enter the number of your choice:"
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
      #table print
      # DOES NOT WORK YET, infinite loop
      workspace.users.each {|user| puts "#{user.real_name} - status: #{user.status_text} - status emoji: #{user.status_emoji} user ID: #{user.slack_id} user-name: #{user.username}"} #to print, user.name, user.real_name
    when "2", "list channels"
      workspace.channels.each {|channel| puts "#{channel}"}
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