require 'mosaic/facebook/error'

# TODO: fix the namespace (ie. module) this should be Mosaic::Facebook::Api::Notification
#       or notification.rb should be moved up a folder
module Mosaic
  module Facebook
    class Notification < Mosaic::Facebook::Api::ApiObject
     
      class << self
        # send_email requires these parameters: to, subject, body, access_token
        def send_email(options)
          response = get("/method/notifications.sendEmail", :query => options)
          raise Mosaic::Facebook::Error.new(response['error_response']) if response.include?('error_response')
          response
        end
      end
    end
  end
end
