#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'
require 'table_print'
require 'httparty'
require 'dotenv'
Dotenv.load

def print_options
  puts "Your options are: \n1. List users \n2. List channels \n3. Select User \n4. Select Channel \n5. Details \n6. Send message \n7. Quit \n\nPlease enter the number of your choice: "
end

def main_select_user(workspace)
  puts "Please enter the id or name of the user you seek:"
  workspace.select_user(gets.chomp)
  if workspace.selected.nil?
    puts "User not found"
  else
    puts "User selected: #{workspace.selected.name}"
  end
  return workspace.selected
end

def main_select_channel(workspace)
  puts "Please enter the id or name of the channel you seek:"
  workspace.select_channel(gets.chomp)
  if workspace.selected.nil?
    puts "Channel not found"
  else
    puts "Channel selected: #{workspace.selected.name}"
  end
  return workspace.selected
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "There are #{workspace.channels.length} channels, and #{workspace.users.length} users."

  print_options
  choice = gets.chomp.downcase

  until choice == "7" || choice == "quit"
    case choice
    when "1", "list users"
      tp workspace.users, :name, :slack_id, :real_name
    when "2", "list channels"
      tp workspace.channels, :name, :slack_id, :topic, :member_count
    when "3", "select user"
      main_select_user(workspace)
    when "4", "select channel"
      main_select_channel(workspace)
    when "5", "details"
      workspace.selected.nil? ? (puts "No user or channel selected"): (puts workspace.show_details)
    when "6", "send message"
      if workspace.selected.nil?
        puts "A valid user or channel has not been selected."
      else
        puts "Please enter message to post:"
        message = gets.chomp
        workspace.send_message(message)
      end
    else
      puts "not a valid choice, please try again"
    end
    puts ""
    print_options
    choice = gets.chomp.downcase
  end

  puts "Thank you for using India & Richelle's Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME