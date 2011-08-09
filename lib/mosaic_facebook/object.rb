module Mosaic
  module Facebook
    class Object
      include HTTParty

      def initialize(attributes = {})
        attributes.each { |key,value| instance_variable_set("@#{key}".to_sym, value) }
      end

      class << self
        def attr_accessor(*names)
          self.attribute_names += names.collect(&:to_s)
          super
        end

        def attribute_names
          @attribute_names ||= []
        end

        def attribute_names=(names)
          @attribute_names = names
        end

        def configuration
          @configuration ||= configuration_from_file
        end

        def configuration_file
          Rails.root.join('config','facebook.yml')
        end

        def configuration_from_file
          YAML.load_file(configuration_file)
        end

        def facebook_access_token
          @facebook_access_token ||= configuration['access_token']
        end

        def facebook_user
          @facebook_user ||= configuration['user']
        end

        def query(path, options)
          result = nil
          ms = Benchmark.ms { result = self.get(path, :query => ( options[:access_token].blank? ? options.reverse_merge(:access_token => facebook_access_token) : options )) }
          Rails.logger.debug "#{self.name} #{path} (%.1fms)  #{options.inspect}" % [ms]
          Rails.logger.debug "#{result.inspect}"
          result
        rescue Exception => e
          Rails.logger.debug "#{e.class.name}: #{e.message}: #{self.name} #{path} #{options.inspect}"
          raise e
        end

      private
        def perform_request_with_retry(http_method, path, options)
          with_retry do
            perform_request_without_retry(http_method, path, options)
          end
        end
        alias_method_chain :perform_request, :retry

        def with_retry(exception = Exception, attempts = 3)
          tries = 0
          begin
            return yield
          rescue exception => e
            if tries < attempts
              tries += 1
              RAILS_DEFAULT_LOGGER.debug "#{e.class.name}: #{e.message}: retry ##{tries}"
              retry
            end
            raise e
          end
        end
      end
    end
  end
end
