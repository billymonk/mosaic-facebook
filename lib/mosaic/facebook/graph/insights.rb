module Mosaic
  module Facebook
    module Graph
      class Insights < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :description, :name, :period, :values
      end
    end
  end
end