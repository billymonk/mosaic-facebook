module Mosaic
  module Facebook
    module Graph
      class AssociationProxy
        def initialize(klass, path, data = nil)
          @klass = klass
          @path = path
          @all = Array(data).collect { |attributes| @klass.new(attributes) } if data
        end

        #TODO: Handle paging
        def all(options = {})
          @all ||= @klass.find(@path, options)
        end

        def create(attributes = {}, options = {})
          @klass.new(attributes).post(@path, options)
          @all = nil
        end
      end
    end
  end
end
