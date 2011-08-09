module Mosaic
  module Facebook
    module Graph
      class User < Mosaic::Facebook::Graph::GraphObject
        attr_accessor :id, :name, :first_name, :last_name, :gender, :locale, :hometown, :location, :birthday, :email #...... link...username...
        
        class << self
          def find_by_id(id, options)
            find("/#{id}", options)
          end

          def me(options)
            find_by_id('me', options)
          end
        end
      end
    end
  end
end
