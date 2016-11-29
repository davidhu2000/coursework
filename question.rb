require_relative 'questions_database'

class Question

  attr_reader :id, :author_id
  attr_accessor :title, :body

  def self.find_by_id(id)
    options = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
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
        questions
      WHERE
        author_id = ?
    SQL
    self.new(options.first)
  end

  def self.find_by_title(title)
    options = QuestionsDatabase.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        questions
      WHERE
        title = ?
    SQL
    self.new(options.first)
    # write methods to account for multiply outputs
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
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

  def replies
  end
end
