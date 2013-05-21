require 'mosaic/facebook/error'

module Mosaic
  module Facebook
    module Fql
      class FqlObject < Mosaic::Facebook::Api::ApiObject
        class << self
          def build_fql(options = {})
            fql = "SELECT #{build_fql_columns(options[:select])}"
            fql << " FROM #{table_name}"
            fql << " WHERE #{build_fql_conditions(options[:conditions])}" if options[:conditions]
            fql
          end

          def build_fql_columns(columns)
            case columns
            when NilClass
              build_fql_columns(attribute_names)
            when String
              columns
            when Array
              columns.collect(&:to_s).join(',')
            else
              columns.to_s
            end
          end

          def build_fql_condition(name, value)
            if value.is_a?(Array)
              "#{name} IN (#{value.join(',')})"
            else
              "#{name} = #{value}"
            end
          end

          def build_fql_conditions(conditions)
            case conditions
            when String
              conditions
            when Hash
              conditions.collect { |name,value| build_fql_condition(name,value) }.join(' AND ')
            else
              raise TypeError, "expected string or hash of FQL conditions"
            end
          end

          def find(*args)
            response = find_by_sql(*args)
            data = response['fql_query_response'][record_name] || []
            data = [data] unless data.is_a?(Array)
            data.collect { |attributes| new(attributes) }
          end

          def find_by_fql(*args)
            response = new.get("/method/fql.query", build_fql(*args))
            raise Mosaic::Facebook::Error.new(response['error_response']) if response.include?('error_response')
            response
          end

          def record_name
            @record_name ||= name.demodulize.underscore
          end

          def table_name
            @table_name ||= name.demodulize.underscore
          end
        end
      end
    end
  end
end
