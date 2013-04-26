module Mosaic
  module Facebook
    module Graph
      class Post < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :created_time, :to, :message, :type, :link, :picture, :updated_time

        def comments
          if @comments.is_a?(Hash)
            @comments = AssociationProxy.new(Mosaic::Facebook::Graph::Comment, "#{BASE_URI}/#{id}/comments", @comments['data'])
          else
            @comments ||= AssociationProxy.new(Mosaic::Facebook::Graph::Comment, "#{BASE_URI}/#{id}/comments")
          end
        end

        def from
          if @from.is_a?(Hash)
            @from = AssociationProxy.new(Mosaic::Facebook::Graph::User, "#{BASE_URI}/#{@from['id']}")
          else
            @from
          end
        end
      end
    end
  end
end
