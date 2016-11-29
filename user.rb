require_relative 'questions_database'

class User

  attr_reader :id
  attr_accessor :fname, :lname

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    User.new(options.first)
  end

  def self.find_by_name(fname, lname)
    options = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    User.new(options.first)
    # write methods to account for multiply outputs
  end

  def initialize(options)
    p options
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

end

# p User.new('fname' => 'Hugh', 'lname' => 'Jackman')
