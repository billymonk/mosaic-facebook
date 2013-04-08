require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper.rb'))

describe Mosaic::Facebook::Graph::Page do
  context "when a valid token and page id are passed" do
    it "should return a page feed" do
      feed = Mosaic::Facebook::Graph::Page.new().feed.all({ :access_token => RSpec.configuration.access_token, :id => RSpec.configuration.page_id })
      feed.should be_an_instance_of Array
      feed.first.should be_an_instance_of Mosaic::Facebook::Graph::Post
    end

    it "should return a event list" do
      events = Mosaic::Facebook::Graph::Page.new().events.all({ :access_token => RSpec.configuration.access_token, :id => RSpec.configuration.page_id })
      events.should be_an_instance_of Array
      events.first.should be_an_instance_of Mosaic::Facebook::Graph::Event
    end
  end
end
