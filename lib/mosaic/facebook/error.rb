module Mosaic
  module Facebook
      class Error < StandardError
        attr_reader :error_code

        def initialize(message, code = nil)
          super(message)
          @error_code = code
        end

        class << self
          def new(error)
            if error.include?('error_code')
              klass = EXCEPTION_CODES[error['error_code'].to_i] || Error
              klass.allocate.tap { |obj| obj.send :initialize, error['error_msg'], error['error_code'].to_i }
            else
              klass = EXCEPTION_TYPES[error['type']] || Error
              klass.allocate.tap { |obj| obj.send :initialize, error['message'] }
            end
          end
        end
      end

      class UnknownError < Mosaic::Facebook::Error
      end

      class ParserError < Mosaic::Facebook::Error
      end

      class AccessTokenError < Mosaic::Facebook::Error
      end

      EXCEPTION_CODES = {
        1 => UnknownError,
        101 => AccessTokenError,
        190 => AccessTokenError,
        601 => ParserError
      }

      EXCEPTION_TYPES = {
        'OAuthException' => AccessTokenError
      }
  end
end
