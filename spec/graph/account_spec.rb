require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Graph::Account, :vcr do
  context "self.all" do
    it "should require an access token" do
      expect { Mosaic::Facebook::Graph::Account.all }.to raise_error(Mosaic::Facebook::AccessTokenError)
    end

    context "when an access token is provided" do
      it "should return the current user's apps and pages" do
        # requires manage_pages permission
        # TODO: update test suite to generate appropriate test users
        accounts = Mosaic::Facebook::Graph::Account.all(:access_token => RSpec.configuration.access_token)
        expect(accounts).to be_an_instance_of Array
        expect(accounts.first).to be_an_instance_of Mosaic::Facebook::Graph::Account
      end
    end
  end

  context "self.find_by_name" do
    it "should find an account for a named page" do
      account = Mosaic::Facebook::Graph::Account.find_by_name('Mosaic (staging)', :access_token => RSpec.configuration.access_token)
      expect(account).to be_an_instance_of Mosaic::Facebook::Graph::Account
    end
  end

  context "given a known account" do
    before(:all) do
      @account = Mosaic::Facebook::Graph::Account.find_by_name('Mosaic (staging)', :access_token => RSpec.configuration.access_token)
    end

    it "should retrieve the insights" do
      # requires read_insights permission
      # TODO: update test suite to generate appropriate test users
      insights = @account.insights.all(:access_token => RSpec.configuration.access_token)
      expect(insights).to be_an_instance_of Array
      expect(insights.first).to be_an_instance_of Mosaic::Facebook::Graph::Insights
    end

    it "should retrieve the posts" do
      # FIXME: limit=3 work-around for facebook bug as per:
      #        https://developers.facebook.com/bugs/525301577527928?browse=search_516709daab5da1453067889
      posts = @account.posts.all(:access_token => RSpec.configuration.access_token, :limit => 3)
      expect(posts).to be_an_instance_of Array
      expect(posts.first).to be_an_instance_of Mosaic::Facebook::Graph::Post
    end
  end
end
