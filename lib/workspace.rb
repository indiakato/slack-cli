require_relative 'user'

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.get_all
    @channels = []
  end

  def print_users

  end

end