class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def self.get(url)

    response = HTTParty.get(url, query: {
        token: ENV["SLACK_TOKEN"]
    }
    )
    return response
  end

  def self.list_all
    raise NotImplementedError
  end
end