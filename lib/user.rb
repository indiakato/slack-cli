require 'awesome_print'
class User
  attr_reader :real_name, :status_emoji, :status_text

  def initialize(real_name, status_text, status_emoji, username, slack_id)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
    @username = username
    @slack_id = slack_id
  end



  def self.get_all
    base_url = "https://slack.com/api/users.list"

    response = HTTParty.get(base_url, query: {
        token: ENV["SLACK_TOKEN"]
    }
    )

    return response["members"].map do |user|
      User.new(user["profile"]["real_name"], user["profile"]["status_text"], user["profile"]["status_emoji"], user["name"], user["id"])
    end
  end

  def details

  end

end