require_relative 'test_helper'

describe "Channel class" do
  it "channel list all method" do

    VCR.use_cassette("channel_instances") do

      all_channels = Channel.list_all

      expect(all_channels).must_be_instance_of Array

      all_channels.each do |channel|
        expect(channel).must_be_instance_of Channel
      end
    end
  end
end