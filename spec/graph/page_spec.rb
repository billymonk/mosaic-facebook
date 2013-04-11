require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Graph::Page do
  context "when a valid token and page id are passed" do
    it "should return a page feed" do
      feed = Mosaic::Facebook::Graph::Page.new().feed.all({ :access_token => RSpec.configuration.access_token, :id => RSpec.configuration.page_id })
      expect(feed).to be_an_instance_of Array
      expect(feed.first).to be_an_instance_of Mosaic::Facebook::Graph::Post
    end

    it "should return a event list" do
      events = Mosaic::Facebook::Graph::Page.new().events.all({ :access_token => RSpec.configuration.access_token, :id => RSpec.configuration.page_id })
      expect(events).to be_an_instance_of Array
      expect(events.first).to be_an_instance_of Mosaic::Facebook::Graph::Event
    end
  end
end
