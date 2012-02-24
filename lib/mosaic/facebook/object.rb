require 'httparty'

module Mosaic
  module Facebook
    class Object
      include HTTParty
      # debug_output

      def initialize(attributes = {})
        attributes.each { |key,value| instance_variable_set("@#{key}".to_sym, value) }
      end

      def delete(path, options = {})
        body = Hash[instance_variables.collect { |ivar| [ivar.sub(/@/,''),instance_variable_get(ivar)] }].to_json
        self.class.delete path, :query => {:access_token => Mosaic::Facebook.access_token}.merge(options), :body => body
      end

      def post(path, options)
        body = Hash[instance_variables.collect { |ivar| [ivar.sub(/@/,''),instance_variable_get(ivar)] }].to_json
        self.class.post path, :query => {:access_token => Mosaic::Facebook.access_token}.merge(options), :body => body
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

        def get(path, options)
          super(path, :query => {:access_token => Mosaic::Facebook.access_token}.merge(options))
        end

      private
        def perform_request_with_retry(http_method, path, options)
          with_retry do
            perform_request_without_retry(http_method, path, options)
          end
        end
        # alias_method_chain :perform_request, :retry
        alias_method :perform_request_without_retry, :perform_request
        alias_method :perform_request, :perform_request_with_retry

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
