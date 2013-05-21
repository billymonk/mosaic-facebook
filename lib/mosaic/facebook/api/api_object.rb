module Mosaic
  module Facebook
    module Api
      class ApiObject < Mosaic::Facebook::Object
        class << self
          def base_uri
            "https://api.facebook.com"
          end
        end
      end
    end
  end
end
