require_relative 'db_connection'
require_relative '01_sql_object'
require_relative 'relation'

module Searchable
  # def where(params)
  #   @relation.where(params)
  #   # attr_names = params.map { |attr_name, _| "#{attr_name} = ?" }.join(' AND ')
  #   #
  #   # res = DBConnection.execute2(<<-SQL, *params.values)
  #   #   SELECT *
  #   #   FROM #{self.table_name}
  #   #   WHERE #{attr_names}
  #   # SQL
  #   #
  #   # self.parse_all(res.drop(1))
  #   self
  # end

  # define_method(:where) do |params|
  #   @relation.send(:where, params)
  #   self
  # end

  [:group, :limit, :order, :offset].each do |name|
    define_method(name) do |*params|
      @relation.send(name, params)
      @relation
    end
  end

  [:where, :having].each do |name|
    define_method(name) do |params|
      @relation.send(name, params)
      @relation
    end
  end
end



class SQLObject
  extend Searchable
end
