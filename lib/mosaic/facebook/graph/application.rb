module Mosaic
  module Facebook
    module Graph
      class Application < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :link

        def subscriptions
          @subscriptions ||= AssociationProxy.new(Mosaic::Facebook::Graph::Subscription, "/#{id}/subscriptions")
        end
      end
    end
  end
end
