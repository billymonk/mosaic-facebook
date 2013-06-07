require 'cgi'

module Mosaic
  module Facebook
    module Graph
      class Application < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :link, :secret

        def access_token
          @access_token ||= get_access_token
        end

        def authorize(token, redirect_uri)
          resp = get('/oauth/access_token', :client_id => id, :client_secret => secret, :code => token, :redirect_uri => redirect_uri)
          body = CGI::parse(resp.body)
          oauth_token = body['access_token'].first
          oauth_token_expiry = body["expires"].first
          user = Mosaic::Facebook::Graph::User.me(:access_token => oauth_token)
          user.oauth_token = oauth_token
          user.oauth_token_expiry = oauth_token_expiry
          user
        end

        def subscriptions
          # requires an application access token
          @subscriptions ||= AssociationProxy.new(Mosaic::Facebook::Graph::Subscription, "/#{id}/subscriptions")
        end

        protected

        def get_access_token
          response = get('/oauth/access_token', :client_id => id, :client_secret => secret, :grant_type => 'client_credentials')
          CGI.parse(response.body)['access_token'].first
        end
      end
    end
  end
end
