module Mosaic
  module Facebook
    module Fql
      class Post < Mosaic::Facebook::Fql::FqlObject
        attr_accessor :id, :action_links, :actor_id, :app_data, :app_id, :attachment, :attribution, :comments, :created_time, :likes, :message, :permalink, :privacy, :source_id, :target_id, :updated_time, :viewer_id

        class << self
          def record_name
            @record_name ||= 'stream_post'
          end

          def table_name
            @table_name ||= 'stream'
          end
        end
      end
    end
  end
end
