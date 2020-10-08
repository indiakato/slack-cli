require_relative 'test_helper'

describe "Workspace class" do
  before do
    VCR.use_cassette("work_space_data") do
      @workspace = Workspace.new
    end
  end

  it "Workspace has a list of users & channels" do
    expect(@workspace.channels).must_be_instance_of Array

    (@workspace.channels).each do |channel|
      expect(channel).must_be_instance_of Channel
    end

    (@workspace.users).each do |user|
      expect(user).must_be_instance_of User
    end
  end

  it "can find a user by ID" do
    user = @workspace.select_user("USLACKBOT")

    expect(user).must_be_instance_of User
    expect(user.name).must_equal "slackbot"
    expect(user.slack_id).must_equal "USLACKBOT"
  end

  it "can find a user by name" do
    user = @workspace.select_user("slackbot")

    expect(user).must_be_instance_of User
    expect(user.slack_id).must_equal "USLACKBOT"
    expect(user.name).must_equal "slackbot"
  end

  it "will return nil for invalid input" do
    user = @workspace.select_user("X")

    expect(user).must_be_nil
  end
end