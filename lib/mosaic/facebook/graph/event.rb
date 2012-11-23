module Mosaic
  module Facebook
    module Graph
      class Event < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :rsvp_status

        class << self
          def find(id, user_id, options = {})
            response = get("/#{id}/invited/#{user_id}", options)
            raise Mosaic::Facebook::Error.new(response['error']) if !response.success?
            data = response.parsed_response
            if data.include?('data')
              data['data'].collect { |attributes| new(attributes) }
            else
              new(data)
            end
          end
        end
      end
    end
  end
end
