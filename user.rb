require_relative 'questions_database'
# require_relative 'question_follow'
require_relative 'question_like'

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

  def save
    @id ? update : create
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
        id = ?
    SQL
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_author_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    karma = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(*) AS FLOAT) / COUNT(DISTINCT(questions.id)) AS avg
      FROM
        question_likes
      JOIN
        questions ON questions.id = question_likes.question_id
      WHERE
        questions.author_id = ?
    SQL
    karma.first['avg']
  end

end

# p User.new('fname' => 'Hugh', 'lname' => 'Jackman')
# p User.find_by_id(1).authored_questions
# p User.find_by_id(1).authored_replies
# p User.find_by_id(1).followed_questions
# p User.find_by_id(2).liked_questions
# p User.find_by_id(1).average_karma

user = User.find_by_id(5)
user.fname = 'G'
user.save
