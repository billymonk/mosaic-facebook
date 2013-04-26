module Mosaic
  module Facebook
    module Graph
      class Page < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :picture, :link, :likes, :category, :can_post, :type, :from, :to

        def events
          @events ||= AssociationProxy.new(Mosaic::Facebook::Graph::Event, "#{BASE_URI}/#{self.id}/events")
        end

        def feed
          @feed ||= AssociationProxy.new(Mosaic::Facebook::Graph::Post, "#{BASE_URI}/#{self.id}/feed")
        end
      end
    end
  end
end
