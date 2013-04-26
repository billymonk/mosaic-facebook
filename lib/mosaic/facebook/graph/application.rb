require 'cgi'

module Mosaic
  module Facebook
    module Graph
      class Application < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :link, :secret

        def access_token
          @access_token ||= get_access_token
        end

        def subscriptions
          # requires an application access token
          @subscriptions ||= AssociationProxy.new(Mosaic::Facebook::Graph::Subscription, "#{BASE_URI}/#{id}/subscriptions")
        end

        protected

        def get_access_token
          response = get("#{BASE_URI}/oauth/access_token", :client_id => id, :client_secret => secret, :grant_type => 'client_credentials')
          CGI.parse(response.body)['access_token'].first
        end
      end
    end
  end
end
