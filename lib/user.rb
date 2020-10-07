require 'awesome_print'
require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_emoji, :status_text

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end



  def self.list_all
    base_url = "https://slack.com/api/users.list"

    response = self.get(base_url)

    return response["members"].map do |user|
      User.new(user["id"], user["name"], user["profile"]["real_name"], user["profile"]["status_text"], user["profile"]["status_emoji"] )
    end
  end

  def details

  end

  def test

  end

end