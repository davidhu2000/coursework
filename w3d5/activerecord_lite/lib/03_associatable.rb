require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    @class_name.constantize.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @class_name  = options[:class_name]  || name.to_s.capitalize
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || "#{self_class_name}_id".downcase.to_sym
    @class_name  = options[:class_name]  || name.to_s.singularize.capitalize
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    assoc_options
    options = BelongsToOptions.new(name, options)

    assoc_options[name] = options
    define_method(name.to_s.underscore) do
      options.class_name.constantize.find(self.send(options.foreign_key))
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name.underscore, options)
    define_method(name.to_s.underscore) do
      res = DBConnection.execute(<<-SQL, self.send(options.primary_key))
        SELECT *
        FROM #{name}
        WHERE #{options.foreign_key} = ?
      SQL
      options.class_name.constantize.parse_all(res)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
  # def self.descendants
  #   ObjectSpace.each_object(Class).select { |klass| klass < self }
  # end

  # everytime a class inherit from SQLObject, run method to create
  # relation object in child class
  def self.inherited(child)
    child.instance_eval do
      @relation = Relation.new(child)
    end
  end
end
