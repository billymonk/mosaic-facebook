module Mosaic
  module Facebook
    module Graph
      class Page < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :picture, :link, :likes, :category, :can_post, :type
        class << self 
          def find_by_id(id, options = {})
            find("/#{id}", options)
          end
        end
      end
    end
  end
end
