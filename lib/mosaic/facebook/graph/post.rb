module Mosaic
  module Facebook
    module Graph
      class Post < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :created_time, :from, :message, :type, :updated_time
      end
    end
  end
end
