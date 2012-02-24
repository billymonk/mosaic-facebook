require 'mosaic/facebook/version'

require 'mosaic/facebook/api'
require 'mosaic/facebook/fql'
require 'mosaic/facebook/graph'

module Mosaic
  module Facebook
    class << self
      attr_accessor :access_token

      def configure
        yield self
      end
    end
  end
end
