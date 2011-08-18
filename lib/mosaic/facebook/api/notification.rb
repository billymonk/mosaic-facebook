require 'mosaic/facebook/error'

module Mosaic
  module Facebook
    class Notification < Mosaic::Facebook::Api::ApiObject
     
      class << self

        # send_email requires these parameters: to, subject, body, access_token
        def send_email(options)
          response = query("/method/notifications.sendEmail", options)
          raise Mosaic::Facebook::Error.new(response['error_response']) if response.include?('error_response')
          response
        end
      end
    end
  end
end
