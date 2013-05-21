module Mosaic
  module Facebook
    module Graph
      class GraphObject < Mosaic::Facebook::Object
        class << self
          def base_uri
            "https://graph.facebook.com"
          end
        end

        def delete(path, options = {})
          response = super(path, options)
          raise Mosaic::Facebook::Error.new(response.body['error']) if !response.success?
          response
        end

        def get(path, options = {})
          response = super(path, options)
          raise Mosaic::Facebook::Error.new(response.body['error']) if !response.success?
          response
        end

        def post(path, options = {})
          response = super(path, options)
          raise Mosaic::Facebook::Error.new(response.body['error']) if !response.success?
          response
        end

        class << self
          def find(path, options = {})
            response = new.get(path, options)
            raise Mosaic::Facebook::Error.new(response.body['error']) if !response.success?
            data = response.body
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
