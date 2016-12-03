require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = assoc_options[through_name]
    source_options = through_options.model_class.assoc_options[source_name]

    through_table = through_options.class_name.constantize.table_name
    source_table = source_options.class_name.constantize.table_name

    define_method(name) do

      res = DBConnection.execute(<<-SQL, self.id)
        SELECT #{source_table}.*
        FROM
          #{source_table}
        JOIN
          #{through_table}
          ON #{source_table}.#{source_options.primary_key}
              = #{through_table}.#{source_options.foreign_key}
        JOIN
          #{self.class.table_name}
          ON #{through_table}.#{through_options.primary_key}
              = #{self.class.table_name}.#{through_options.foreign_key}
        WHERE
          #{self.class.table_name}.id = ?
      SQL

      source_options.class_name.constantize.parse_all(res).first
    end
  end
end
