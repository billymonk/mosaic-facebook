module Mosaic
  module Facebook
    module Graph
      class Account < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :access_token, :category

        def insights
          @insights ||= AssociationProxy.new(Mosaic::Facebook::Graph::Insights, "/#{self.id}/insights")
        end

        def posts
          @posts ||= AssociationProxy.new(Mosaic::Facebook::Graph::Post, "/#{self.id}/posts")
        end
        
        def user
          @user ||= AssociationProxy.new(Mosaic::Facebook::Graph::User, "/me")
        end

        class << self
          def all
            # need 'manage_pages' extended permission to get pages (via accounts connection)
            @all ||= find("/#{facebook_user}/accounts")
          end
          
          def find_by_name(name)
            all.find { |account| account.name == name }
          end
        end
      end
    end
  end
end
