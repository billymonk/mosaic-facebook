module Mosaic
  module Facebook
    module Graph
      class GraphObject < Mosaic::Facebook::Object
        base_uri 'https://graph.facebook.com'

        def delete(path, options = {})
          response = super(path, options)
          raise Mosaic::Facebook::Error.new(response['error']) if !response.success?
          response
        end

        def post(path, options = {})
          response = super(path, options)
          raise Mosaic::Facebook::Error.new(response['error']) if !response.success?
          response
        end

        class << self
          def find(path, options = {})
            response = get(path, options)
            raise Mosaic::Facebook::Error.new(response['error']) if !response.success?
            data = response.parsed_response
            if data.include?('data')
              data['data'].collect { |attributes| new(attributes) }
            else
              new(data)
            end
          end

          def find_by_id(id, options = {})
            find("/#{id}", options)
          end
        end

        private
          def serialize_body(body)
            body
          end
      end
    end
  end
end
