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

def select_user(workspace)
  puts "Please enter the id or name of the user you seek:"
  recipient = workspace.select_user(gets.chomp)
  if recipient.nil?
    puts "User not found"
  else
    puts "User selected: #{recipient.name}"
  end
  return recipient
end

def select_channel(workspace)
  puts "Please enter the id or name of the channel you seek:"
  recipient = workspace.select_channel(gets.chomp)
  if recipient.nil?
    puts "Channel not found"
  else
    puts "Channel selected: #{recipient.name}"
  end
  return recipient
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  recipient = nil
  puts "There are #{workspace.channels.length} channels, and #{workspace.users.length} users."

  print_options
  choice = gets.chomp.downcase

  until choice == "7" || choice == "quit"
    case choice
    when "1", "list users"
      tp workspace.users, :name, :slack_id, :real_name

      # workspace.users.each { |user| puts "#{user.real_name} - status: #{user.status_text} - status emoji: #{user.status_emoji} user ID: #{user.slack_id} user-name: #{user.name}"}
    when "2", "list channels"
      tp workspace.channels, :name, :slack_id, :topic, :member_count

      #workspace.channels.each { |channel| puts "Channel ID:#{channel.slack_id} - Name: #{channel.name} - Topic: #{channel.topic} - Number of members: #{channel.member_count}" }
    when "3", "select user"
      recipient = select_user(workspace)
    when "4", "select channel"
      recipient = select_channel(workspace)
    when "5", "details"
      if recipient.nil?
        puts "No user or channel selected"
      else
        puts workspace.show_details
      end
    when "6", "send message"
      if recipient.nil? || recipient.instance_of?(User)
        puts "Invalid channel, you must have a channel selected"
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

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME