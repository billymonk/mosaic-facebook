module Mosaic
  module Facebook
    module Graph
      class Event < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :description, :start_time, :end_time, :location, :venue, :updated_time, :picture, :ticket_uri, :privacy, :owner, :cover
      end
    end
  end
end
