require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels
  attr_accessor :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_user(input)
    @selected = @users.find { |user| user.name == input }
    if @selected
      return @selected
    else
      @selected = @users.find { |user| user.slack_id == input }
    end
    return @selected
  end

  def select_channel(input)
    @selected = @channels.find { |channel| channel.name == input }
    if @selected
      return @selected
    else
      @selected = @channels.find { |channel| channel.slack_id == input }
    end
    return @selected
  end

  def show_details
    @selected.details
  end

end