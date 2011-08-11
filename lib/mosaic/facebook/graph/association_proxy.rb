module Mosaic
  module Facebook
    module Graph
      class AssociationProxy
        def initialize(klass, path)
          @klass = klass
          @path = path
        end

        def all(options = {})
          @klass.find(@path, options)
        end
      end
    end
  end
end
