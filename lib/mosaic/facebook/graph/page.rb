module Mosaic
  module Facebook
    module Graph
      class Page < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :picture, :link, :likes, :category, :can_post, :type, :from, :to

        def feed
          @feed ||= AssociationProxy.new(Mosaic::Facebook::Graph::Post, "/#{self.id}/feed")
        end
      end
    end
  end
end
