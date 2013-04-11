require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Graph::User do
  context "#me" do
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
end
