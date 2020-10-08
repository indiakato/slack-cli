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

  it "can find a channel by ID" do
    channel = @workspace.select_channel("C01ABK51G14")

    expect(channel).must_be_instance_of Channel
    expect(channel.name).must_equal "test-channel2"
    expect(channel.slack_id).must_equal "C01ABK51G14"
  end

  it "can find a channel by name" do
    channel = @workspace.select_channel("test-channel2")

    expect(channel).must_be_instance_of Channel
    expect(channel.slack_id).must_equal "C01ABK51G14"
    expect(channel.name).must_equal "test-channel2"
  end

  it "will return nil for invalid input" do
    channel = @workspace.select_channel("X")

    expect(channel).must_be_nil
  end

end