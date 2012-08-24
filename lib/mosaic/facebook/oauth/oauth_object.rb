module Mosaic
  module Facebook
    module Oauth
      class OauthObject < Mosaic::Facebook::Object
        base_uri 'https://graph.facebook.com'

        class << self
          def find_with_code(path, options = {})
            response = get(path, options)
            raise Mosaic::Facebook::Error.new(response['error']) if !response.success?
            new Rack::Utils.parse_query(response.parsed_response)
          end
        end

      end
    end
  end
end
