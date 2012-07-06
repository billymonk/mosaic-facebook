module Mosaic
  module Facebook
    module Oauth
      class Oauth
        include HTTParty

        def initialize(attributes = {})
          attributes.each { |key,value| instance_variable_set("@#{key}".to_sym, value) }
        end

        def access_token
          result = nil
          ms = Benchmark.ms { result = HTTParty.get(access_token_url, :query => access_token_options) }
          Rails.logger.debug "#{result.inspect}"
          Rails.logger.debug "#{access_token_url} (%.1fms) " % [ms]
          Rack::Utils.parse_query(result)
        rescue Exception => e
          Rails.logger.debug "#{e.class.name}: #{e.message}: #{access_token_url}"
          raise e
        end

        protected

          def access_token_url
            "https://graph.facebook.com/oauth/access_token"
          end

          def access_token_options
            { :client_id => @client_id, :redirect_uri => @redirect_uri, :client_secret => @client_secret, :code => @code, :grant_type => @grant_type }
          end

      end
    end
  end
end
