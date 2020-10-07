require 'awesome_print'

class Channel
  attr_reader :slack_id, :channel_name, :topic, :member_count

  def initialize(slack_id, channel_name, topic, member_count)
    @slack_id = slack_id
    @channel_name = channel_name
    @topic = topic
    @member_count = member_count
  end

  def self.get_all
    base_url = "https://slack.com/api/conversations.list"

    response = HTTParty.get(base_url, query: {
        token: ENV["SLACK_TOKEN"]
    }
    )

    return response["channels"].map do |channel|
      Channel.new(channel["id"], channel["name"], channel["topic"]["value"], channel["num_members"] )
    end
  end
end