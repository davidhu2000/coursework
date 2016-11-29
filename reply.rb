require_relative 'questions_database'

class Reply

  attr_reader :id, :question_id, :parent_id, :author_id
  attr_accessor :body

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    self.new(options.first)
  end

  def self.find_by_author_id(author_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL
    self.new(options.first)
  end

  def self.find_by_question_id(question_id)
    options = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    options.map { |option| self.new(option) }
  end


  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @author_id = options['author_id']
    @body = options['body']
  end

  def author
    author_name = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
      SELECT
        fname,
        lname
      FROM
        users
      WHERE
        id = ?
    SQL
    author_name.first.values.join(" ")
  end

  def question
    question_name = QuestionsDatabase.instance.execute(<<-SQL, @question_id)
      SELECT
        title,
        body
      FROM
        questions
      WHERE
        id = ?
    SQL
    question_name.first
  end

  def parent_reply
    raise "no parent" if @parent_id.nil?
    reply = QuestionsDatabase.instance.execute(<<-SQL, @parent_id)
      SELECT
        body
      FROM
        replies
      WHERE
        id = ?
    SQL
    reply.first
  end

  def child_replies

    reply = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        body
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    reply
  end

end
# 
# p Reply.find_by_id(1).author
# p Reply.find_by_id(2).question
# p Reply.find_by_id(2).parent_reply
# p Reply.find_by_id(1).child_replies
