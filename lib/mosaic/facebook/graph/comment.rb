module Mosaic
  module Facebook
    module Graph
      class Comment < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :from, :message, :created_time, :likes, :user_likes
      end
    end
  end
end
