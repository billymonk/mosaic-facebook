module Mosaic
  module Facebook
      class Error < StandardError
        attr_reader :error_code

        def initialize(error_response)
          super(error_response['error_msg'])
          @error_code = error_response['error_code'].to_i
        end

        class << self
          def new(error_response)
            klass = EXCEPTIONS[error_response['error_code'].to_i] || Error
            klass.allocate.tap { |obj| obj.send :initialize, error_response }
          end
        end
      end

      class UnknownError < Mosaic::Facebook::Error
      end

      class ParserError < Mosaic::Facebook::Error
      end

      class AccessTokenError < Mosaic::Facebook::Error
      end

      EXCEPTIONS = {
        1 => UnknownError,
        101 => AccessTokenError,
        190 => AccessTokenError,
        601 => ParserError
      }
    
  end
end
