require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Graph::User do
  context "self.me" do
    it "should require an access token" do
      expect { Mosaic::Facebook::Graph::User.me }.to raise_error(Mosaic::Facebook::AccessTokenError, /An active access token must be used/i)
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
      @me = Mosaic::Facebook::Graph::User.me(:access_token => RSpec.configuration.access_token)
    end

    context "#accounts" do
      it "should require an access token" do
        expect { @me.accounts.all }.to raise_error(Mosaic::Facebook::AccessTokenError, /An access token is required to request this resource./i)
      end

      context "when an access token is provided" do
        it "should return the user's apps and pages" do
          accounts = @me.accounts.all(:access_token => RSpec.configuration.access_token)
          expect(accounts).to be_an_instance_of Array
          expect(accounts.first).to be_an_instance_of Mosaic::Facebook::Graph::Account
        end
      end
    end
  end
end
