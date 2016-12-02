require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # cols = DBConnection.execute(<<-SQL)
    #   PRAGMA table_info(#{self.table_name});
    # SQL
    # cols.map { |col| col['name'].to_sym }

    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT * FROM #{table_name} LIMIT 1
    SQL
    @columns.first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|
      define_method(column) do
        attributes[column]
      end

      define_method("#{column}=") do |val|
        attributes[column] = val
      end
    end
  end

  class << self
    attr_writer :table_name
  end

  def self.table_name
    @table_name ||= name.tableize
  end

  def self.all
    result = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{self.table_name}
    SQL
    parse_all(result)
  end

  def self.parse_all(_results)
    _results.map do |params|
      self.new(params)
    end
  end

  def self.find(_id)
    result = DBConnection.execute(<<-SQL, _id)
      SELECT *
      FROM #{self.table_name}
      WHERE id = ?
    SQL
    parse_all(result).first
  end

  def initialize(params = {})
    attributes
    self.class.finalize!
    params.each do |attr_name, attr_val|
      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name}'"
      end
      self.send("#{attr_name}=", attr_val)
    end

  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    vals = []
    self.class.columns.each do |col|
      vals << self.send(col)
    end
    vals.compact
  end

  def insert
    col_names = self.class.columns
    col_names.delete(:id)
    question_marks = (['?'] * col_names.count).join(', ')
    col_names = col_names.join(', ')

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO #{self.class.table_name} (#{col_names})
      VALUES (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    col_names = self.class.columns
    col_names.delete(:id)
    col_names.map! { |name| "#{name}= ?" }
    col_names = col_names.join(', ')
    attribute_val = attribute_values
    attribute_val << attribute_val.shift

    DBConnection.execute(<<-SQL, *attribute_val)
      UPDATE #{self.class.table_name}
      SET #{col_names}
      WHERE id = ?
    SQL
  end

  def save
    attributes[:id] ? update : insert
  end
end
