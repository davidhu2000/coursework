require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    attr_names = params.map { |attr_name, _| "#{attr_name} = ?" }.join(' AND ')

    res = DBConnection.execute2(<<-SQL, *params.values)
      SELECT *
      FROM #{self.table_name}
      WHERE #{attr_names}
    SQL

    self.parse_all(res.drop(1))
  end
end

class SQLObject
  extend Searchable
end

class Relation
  attr_reader :params
  def initialize(klass)
    @klass = klass
    @params = {}
  end

  def where(params)
    assign(__callee__, params)
  end

  def group(*params)
    assign(__callee__, params)
  end

  def assign(method_name, params)
    @params[method_name] ||= {}
    params.each do |attr_name, value|
      @params[method_name][attr_name] = value
    end
  end

  def method_missing(method_name, *args)
    if @klass.respond_to?(method_name)

      conditions = @params[:where]

      attr_values = conditions.values

      where_string = conditions.map { |attr_name, _| "#{attr_name} = ?"}.join(' AND ')

      res = DBConnection.execute(<<-SQL, *attr_values)
        SELECT *
        FROM #{@klass.table_name}
        WHERE #{where_string}
      SQL

      @klass.parse_all(res)
    else
      super
    end
  end
end

class Cat < SQLObject
end
