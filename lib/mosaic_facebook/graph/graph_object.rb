module Mosaic
  module Facebook
    module Graph
      class GraphObject < Mosaic::Facebook::Object
        base_uri 'https://graph.facebook.com'

        class << self
          def find(path, options = {})
            data = query(path, options).parsed_response || []
            # data = [data] unless data.is_a?(Array)
            new(data)
            # data.collect { |attributes| new(attributes) }
          end
        end
      end
    end
  end
end
