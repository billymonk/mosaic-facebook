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

        class << self
          def all(options = {})
            # need 'manage_pages' extended permission to get pages (via accounts connection)
            @all ||= find("/#{facebook_user}/accounts", options)
          end
          
          def find_by_name(name, options = {})
            all(options).find { |account| account.name == name }
          end
        end
      end
    end
  end
end
