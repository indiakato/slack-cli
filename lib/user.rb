require 'awesome_print'
require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_emoji, :status_text

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
    empty_status
  end

  def self.list_all
    base_url = "https://slack.com/api/users.list"

    response = self.get(base_url)

    return response["members"].map do |user|
      User.new(user["id"], user["name"], user["profile"]["real_name"], user["profile"]["status_text"], user["profile"]["status_emoji"] )
    end
  end

  def details
    return "This user's id is: #{@slack_id}, the username is: #{@name} and their real name is: #{@real_name}. They have a status emoji of: #{@status_emoji} and their status text is: #{@status_text}"
  end

  private
  def empty_status
    if @status_emoji == ""
      @status_emoji = "N/A"
    end

    if @status_text == ""
      @status_text = "N/A"
    end
  end
end