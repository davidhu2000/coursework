require_relative 'db_connection'
require_relative '01_sql_object'
require_relative 'relation'

module Searchable

  [:select, :group, :limit, :order, :offset].each do |name|
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
