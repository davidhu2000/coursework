require_relative 'questions_database'

class ModelBase

  def self.get_table_name
    table_name = self.name.to_s.downcase
    if table_name == 'reply'
      'replies'
    else
      table_name + 's'
    end
  end

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{get_table_name}
      WHERE
        id = ?
    SQL
    self.new(options.first)
  end

  def self.all
    records = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{get_table_name}
    SQL
    records.map do |record|
      self.new(record)
    end
  end

  def save
    @id ? update : create
  end

  def create
    vars = get_vars
    vars.shift
    str = vars.join(', ')
    vars.map! { |var| self.instance_variable_get(var.to_s)}

    QuestionsDatabase.instance.execute(<<-SQL, *vars)
      INSERT INTO
        #{self.class.get_table_name} ( #{str.gsub('@','')} )
      VALUES
        ( #{(['?'] * vars.count).join(', ')} )
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    vars = get_vars
    vars << vars.shift
    input = vars.map { |var| self.instance_variable_get(var.to_s)}
    vars = vars[0..-2].map { |var| var.to_s + ' = ?' }.join(', ').gsub('@','')
    QuestionsDatabase.instance.execute(<<-SQL, *input)
      UPDATE
        #{self.class.get_table_name}
      SET
        #{vars}
      WHERE
        id = ?
    SQL
  end

  def get_vars
    self.instance_variables
  end

end
