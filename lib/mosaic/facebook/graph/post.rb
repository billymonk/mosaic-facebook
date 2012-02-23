module Mosaic
  module Facebook
    module Graph
      class Post < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :created_time, :to, :message, :type, :link, :picture, :updated_time

        def from
          if @from.is_a?(Hash)
            @from = AssociationProxy.new(Mosaic::Facebook::Graph::User, "/#{@from['id']}")
          else
            @from
          end
        end
      end
    end
  end
end
