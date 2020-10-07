#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user.rb'
require_relative 'channel.rb'
require 'httparty'
require 'dotenv'
Dotenv.load



def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "There are #{workspace.channels.length} channels, and #{workspace.users.length} users."

  puts "Your option are: \n1. List users \n2. List channels \n3. Quit \nPlease enter the number of your choice:"
  choice = gets.chomp

  until choice == "3"
    case choice
    when "1"
      #table print
      # DOES NOT WORK YET, infinite loop
      workspace.users.each {|user| puts "#{user}"}
    when "2"
      workspace.channels.each {|channel| puts "#{channel}"}
    else
      puts "Not a valid input, what is your choice?"
      choice = gets.chomp
    end
  end


  # TODO project


  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME