require_relative 'test_helper'

describe "Channel class" do
  it "channel get_all" do

    VCR.use_cassette("channel_instances") do

      all_channels = Channel.get_all

      expect(all_channels).must_be_instance_of Array

      all_channels.each do |channel|
        expect(channel).must_be_instance_of Channel
      end
    end
  end
end