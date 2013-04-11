require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Notification do
  def options
    options = {:recipients => "000000000", :subject => "testing", :text => "ajit", :access_token => "xxx"}
  end

  context "when no or invalid token is passed" do
    it "should require an access_token" do
      lambda { Mosaic::Facebook::Notification.send_email(options.merge(:access_token => nil)) }.should raise_error(Mosaic::Facebook::AccessTokenError, /Invalid application ID/i)
    end

    it "should require a valid access_token" do
      lambda {Mosaic::Facebook::Notification.send_email(options.merge(:recipients => RSpec.configuration.user_id))}.should raise_error(Mosaic::Facebook::AccessTokenError, /INVALID OAUTH ACCESS TOKEN/i)
    end

  end

  context "when a valid access_token is provided" do
    it "should send a notification" do
      Mosaic::Facebook::Notification.send_email(options.merge(:recipients => RSpec.configuration.user_id, :access_token => RSpec.configuration.access_token))
    end
  end
end
