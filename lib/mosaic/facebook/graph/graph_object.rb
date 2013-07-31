module Mosaic
  module Facebook
    module Graph
      class GraphObject < Mosaic::Facebook::Object
        class << self
          def base_uri
            'https://graph.facebook.com'
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

          def batch(paths = [], options = {})
            uris = paths.map{|path| {'method' => 'GET', 'relative_url' => path}}
            conn = new.send(:instance_variable_get, :@conn)
            response = conn.post base_uri, {:batch => uris.to_json, :access_token => facebook_access_token}.merge(options)
            raise Mosaic::Facebook::Error.new(response.body['error']) if !response.success?
            data = response.body
            data.map do |datum|
              if datum.include?('data')
              datum['data'].collect { |attributes| new(attributes) }
              else
                new(JSON.parse(datum['body']))
              end
            end
          end

          def search(query, options = {})
            find("/search?q=#{URI.escape(query)}&type=#{self.name.split('::').last.downcase}", options)
          end

          def find_by_id(id, options = {})
            find("/#{id}", options)
          end

          def find_by_ids(ids, options = {})
            batch(ids.map{|i|"/#{i}"}, options)
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
