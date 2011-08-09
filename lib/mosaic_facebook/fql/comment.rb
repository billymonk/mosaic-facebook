module Mosaic
  module Facebook
    module Fql
      class Comment < Mosaic::Facebook::Fql::FqlObject
        attr_accessor :id, :fromid, :post_id, :text, :time
      end
    end
  end
end
