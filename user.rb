require_relative 'questions_database'
require_relative 'question'

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
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_author_id(@id)
  end

end

# p User.new('fname' => 'Hugh', 'lname' => 'Jackman')
p User.find_by_id(1).authored_questions
p User.find_by_id(1).authored_replies
