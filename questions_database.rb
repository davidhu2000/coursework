require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLlite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = trues
  end
end
