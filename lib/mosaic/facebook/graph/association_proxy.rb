module Mosaic
  module Facebook
    module Graph
      class AssociationProxy
        def initialize(klass, path)
          @klass = klass
          @path = path
        end

        def all(options = {})
          @all ||= @klass.find(@path, options)
        end

        def create(attributes = {}, options = {})
          @klass.new(attributes).post(@path, options)
        end
      end
    end
  end
end
