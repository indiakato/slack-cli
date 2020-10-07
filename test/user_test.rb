require_relative 'test_helper'

describe "User class" do
  it "user list_all method" do

    VCR.use_cassette("user_instances") do
      all_users = User.list_all

      expect(all_users).must_be_instance_of Array

      all_users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end
end