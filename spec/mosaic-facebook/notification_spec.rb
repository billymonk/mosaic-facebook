require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper.rb'))


describe Mosaic::Facebook::Notification do
  def options
    options = {:recipients => "535004545", :subject => "testing", :text => "ajit", :access_token => "xxx"}
  end

  context "when no or invalid token is passed" do
    it "should require an access_token" do
      lambda { Mosaic::Facebook::Notification.send_email(options.merge(:access_token => nil)) }.should raise_error(Mosaic::Facebook::AccessTokenError, /INVALID API KEY/i)
    end

    it "should require a valid access_token" do
      lambda {Mosaic::Facebook::Notification.send_email(options)}.should raise_error(Mosaic::Facebook::AccessTokenError, /INVALID OAUTH ACCESS TOKEN/i)
    end

  end


  context "when a valid access_token is provided" do
    it "should send a notification" do
      Mosaic::Facebook::Notification.send_email(options.merge(:access_token => FBK_CREDS[:token]))
    end
  end
end