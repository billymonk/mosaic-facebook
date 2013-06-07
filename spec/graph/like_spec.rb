require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Graph::Like, :vcr do
  context "with a valid access token" do
    it "should fetch all likes" do
      likes = Mosaic::Facebook::Graph::Like.all('joe.pym', :access_token => RSpec.configuration.access_token)
      expect(likes).to be_an_instance_of Array
      expect(likes.first).to be_an_instance_of Mosaic::Facebook::Graph::Like
    end

    it "should be able to find if a page is liked" do
      likes = Mosaic::Facebook::Graph::Like.find_by_id(Rspec.configuration.user_id, RSpec.configuration.page_id, :access_token => RSpec.configuration.access_token)
      expect(likes).to be_an_instance_of Array
      expect(likes.first).to be_an_instance_of Mosaic::Facebook::Graph::Like
    end

    it "should be able to find if a page is not liked" do
      likes = Mosaic::Facebook::Graph::Like.find_by_id(Rspec.configuration.user_id, 12345, :access_token => RSpec.configuration.access_token)
      expect(likes).to be_an_instance_of Array
      expect(likes).to be_empty

    end

  end
end
