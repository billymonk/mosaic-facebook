require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Graph::Page do
  context "given a valid page" do
    before(:all) do
      @page = Mosaic::Facebook::Graph::Page.new(:id => RSpec.configuration.page_id)
    end

    context "with a valid access token" do
      it "should return a page feed" do
        # FIXME: limit=3 work-around for facebook bug as per:
        #        https://developers.facebook.com/bugs/525301577527928?browse=search_516709daab5da1453067889
        feed = @page.feed.all(:access_token => RSpec.configuration.access_token, :limit => 3)
        expect(feed).to be_an_instance_of Array
        expect(feed.first).to be_an_instance_of Mosaic::Facebook::Graph::Post
      end

      it "should return a event list" do
        events = @page.events.all(:access_token => RSpec.configuration.access_token)
        expect(events).to be_an_instance_of Array
        expect(events.first).to be_an_instance_of Mosaic::Facebook::Graph::Event
      end
    end
  end
end
