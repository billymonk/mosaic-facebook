require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Graph::Application, :vcr do
  context "self.find_by_id" do
    it "should require an access token" do
      expect { Mosaic::Facebook::Graph::Application.find_by_id(RSpec.configuration.app_id) }.to raise_error(Mosaic::Facebook::Error, /unsupported get request/i)
    end

    context "with an access token" do
      it "should find an application" do
        application = Mosaic::Facebook::Graph::Application.find_by_id(RSpec.configuration.app_id, :access_token => RSpec.configuration.access_token)
        expect(application).to be_an_instance_of(Mosaic::Facebook::Graph::Application)
      end
    end
  end

  context "given an application (and a client secret)" do
    before(:all) do
      @application = Mosaic::Facebook::Graph::Application.new(:id => RSpec.configuration.app_id, :secret => RSpec.configuration.app_secret)
    end

    it "should retrieve an access token" do
      access_token = @application.access_token
      expect(access_token).to be_an_instance_of String
    end

    it "should return a list of subscriptions" do
      # requires an application access token
      subscriptions = @application.subscriptions.all(:access_token => @application.access_token)
      expect(subscriptions).to be_an_instance_of Array
      # TODO: add subscription to test?
      # expect(subscriptions.first).to be_an_instance_of Mosaic::Facebook::Graph::Subscription
    end

    it "should authorize a user and set up a new user correctly" do
      user = @application.authorize(Rspec.configuration.oauth_code, Rspec.configuration.oauth_redirect_url)
      expect(user).to be_an_instance_of(Mosaic::Facebook::Graph::User)
      user.oauth_token.should eql("access_token")
      user.oauth_token_expiry.should eql("5183557")
      user.name.should eql("Example User")
      user
    end

  end
end
