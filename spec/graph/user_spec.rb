require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Graph::User, :vcr do
  context "self.me" do
    it "should require an access token" do
      expect { Mosaic::Facebook::Graph::User.me }.to raise_error(Mosaic::Facebook::AccessTokenError)
    end

    context "when an access token is provided" do
      it "should return the current user" do
        me = Mosaic::Facebook::Graph::User.me(:access_token => RSpec.configuration.access_token)
        expect(me).to be_an_instance_of Mosaic::Facebook::Graph::User
      end
    end
  end

  context "given a valid user" do
    before(:all) do
      @me = Mosaic::Facebook::Graph::User.new(:id => 'me')
    end

    context "#accounts" do
      it "should require an access token" do
        expect { @me.accounts.all }.to raise_error(Mosaic::Facebook::AccessTokenError)
      end

      context "when a valid access token is provided" do
        # requires manage_pages permission
        # TODO: update test suite to generate appropriate test users
        it "should return the user's apps and pages" do
          accounts = @me.accounts.all(:access_token => RSpec.configuration.access_token)
          expect(accounts).to be_an_instance_of Array
          expect(accounts.first).to be_an_instance_of Mosaic::Facebook::Graph::Account
        end
      end
    end

    it "should be able to retrieve likes" do
      @me.oauth_token = RSpec.configuration.access_token
      Mosaic::Facebook::Graph::Like.should_receive(:all).with(@me.username, :access_token => RSpec.configuration.access_token)
      @me.likes
    end
  end
end
