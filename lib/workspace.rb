require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  def print_users
    #table print?
  end

  def select_user(input)
    found_user = @users.find { |user| user.name == input }
    if found_user
      return found_user
    else
      found_user = @users.find { |user| user.slack_id == input }
    end
    return found_user
  end

  def select_channel(input)
    found_channel = @channels.find { |channel| channel.name == input }
    if found_channel
      return found_channel
    else
      found_channel = @channels.find { |channel| channel.slack_id == input }
    end
    return found_channel
  end

  def show_details(recipient)
    recipient.details
  end

end