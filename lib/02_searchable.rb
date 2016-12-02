require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    attr_values = params.values
    attr_names = params.map { |attr_name, value| "#{attr_name} = ?" }.join(' AND ')

    res = DBConnection.execute2(<<-SQL, *params.values)
      SELECT *
      FROM #{self.table_name}
      WHERE #{attr_names}
    SQL

    options.class_name.constantize.parse_all(res.drop(1))
  end
end

class SQLObject
  extend Searchable
end
