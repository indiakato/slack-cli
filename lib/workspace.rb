require_relative 'user'

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = []
    @channels = []
  end


end