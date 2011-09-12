module Mosaic
  module Facebook
    module Graph
      class Page < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :picture, :link, :likes, :category, :can_post, :type
      end
    end
  end
end
