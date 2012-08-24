module Mosaic
  module Facebook
    module Oauth
      class AccessToken < Mosaic::Facebook::Oauth::OauthObject
        attr_accessor :access_token, :expire

        class << self
          def find(options = {})
            find_with_code('/oauth/access_token', options)
          end
        end
      end
    end
  end
end
