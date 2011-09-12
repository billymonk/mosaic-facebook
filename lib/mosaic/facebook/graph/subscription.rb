module Mosaic
  module Facebook
    module Graph
      class Subscription < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :object, :fields, :callback_url, :verify_token
      end
    end
  end
end
