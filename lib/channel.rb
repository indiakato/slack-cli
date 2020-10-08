require 'awesome_print'
require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def self.list_all
    base_url = "https://slack.com/api/conversations.list"

    response = self.get(base_url)

    return response["channels"].map do |channel|
      Channel.new(channel["id"], channel["name"], channel["topic"]["value"], channel["num_members"] )
    end
  end

  def details
    return "This channel's id is: #{@slack_id}, the name is: #{@name}. This channel has #{@member_count} members and is about #{@topic}"
  end
end