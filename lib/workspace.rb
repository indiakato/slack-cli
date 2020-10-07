require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.get_all
    @channels = Channel.get_all
  end

  def print_users
    #table print?
  end

end