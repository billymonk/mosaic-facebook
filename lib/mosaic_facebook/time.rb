module Mosaic
  module Facebook
    class Time < ::Time
      class << self
        def at(time)
          use_pacific_zone { Time.zone.at(time) }
        end

        def parse(text)
          use_pacific_zone { Time.zone.parse(text) }
        end

        def use_pacific_zone
          use_zone('Pacific Time (US & Canada)') { yield }
        end
      end
    end
  end
end
