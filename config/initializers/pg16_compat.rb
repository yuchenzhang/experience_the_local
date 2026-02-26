require 'active_record/connection_adapters/postgresql_adapter'

module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      def set_standard_conforming_strings
        old, self.client_min_messages = client_min_messages, 'error'
        execute('SET standard_conforming_strings = on', 'SCHEMA') rescue nil
      ensure
        self.client_min_messages = old
      end
    end
  end
end

require 'arel/visitors/to_sql'

module Arel
  module Visitors
    class ToSql < Arel::Visitors::Visitor
      unless method_defined?(:visit_Integer)
        alias_method :visit_Integer, :literal
      end
    end

    class DepthFirst < Arel::Visitors::Visitor
      unless method_defined?(:visit_Integer)
        alias_method :visit_Integer, :terminal
      end
    end
  end
end
