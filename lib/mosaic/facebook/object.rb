require 'faraday'
require 'faraday_middleware'
require 'mosaic/facebook/error'
require 'multi_xml'

module Mosaic
  module Facebook
    class Object
      # debug_output

      def initialize(attributes = {})
        attributes.each { |key,value| instance_variable_set("@#{key}".to_sym, value) }

        @conn = Faraday.new do |faraday|
          faraday.request :retry, :max => 3,
            :exceptions => [Exception, Mosaic::Facebook::UnknownError]
          faraday.request :url_encoded
          faraday.response :json, :content_type => /\bjson$/
          faraday.response :xml,  :content_type => /\bxml$/

          faraday.adapter Faraday.default_adapter
        end
      end

      def get(path, options = {})
        query = { :access_token => self.class.facebook_access_token }.merge(options)
        @conn.get path, query
      end

      def post(path, options)
        query = { :access_token => self.class.facebook_access_token }.merge(options)
        body = Hash[instance_variables.collect { |ivar| [ivar.sub(/@/,''),instance_variable_get(ivar)] }]
        @conn.post path, :query => query, :body => serialize_body(body)
      end

      class << self
        def attr_name(*names)
          self.attribute_names += names.collect(&:to_s)
        end

        def attr_accessor(*names)
          attr_name(*names)
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

        def configuration_from_file
          YAML.load_file(@configuration_file) rescue nil
        end

        def facebook_access_token
          @facebook_access_token ||= configuration && configuration['access_token']
        end

      private
        def logger
          @logger ||= if defined?(Rails)
            Rails.logger
          else
            require 'logger'
            Logger.new(STDOUT)
          end
        end

        def serialize_body(body)
          body.to_json
        end
      end
    end
  end
end
