class SlackApiError < Exception; end

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    url = "https://slack.com/api/chat.postMessage"

    response = HTTParty.post(url, body: {
        token: ENV["SLACK_TOKEN"],
        text: message,
        channel: @slack_id
    }
    )
    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "Error when posting #{message} to #{@name}, error: #{response.parsed_response["error"]}"
    end
    return response.code == 200 && response.parsed_response["ok"]
  end

  def self.get(url)
    response = HTTParty.get(url, query: {
        token: ENV["SLACK_TOKEN"]
    }
    )
    unless response.code == 200 && response.parsed_response["ok"]
      raise SlackApiError, "Error connecting to Slack API: #{response.code} - #{response.parsed_response["error"]} - url: #{url}, please try again later."
    end
    return response
  end

  def self.list_all
    raise NotImplementedError
  end

  def self.details
    raise NotImplementedError
  end

end