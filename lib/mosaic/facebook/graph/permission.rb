module Mosaic
  module Facebook
    module Graph
      class Permission < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :name, :enabled

        class << self
          def all(options = {})
            @all ||= find("/#{facebook_user}/permissions", options)
          end

          def find(path, options = {})
            response = get(path, options)
            raise Mosaic::Facebook::Error.new(response['error']) if !response.success?
            data = response.parsed_response
            if data.include?('data')
              data['data'].first.collect { |key,value| new({ :name => key, :enabled => value}) }
            else
              new(data)
            end
          end
        end
      end
    end
  end
end
