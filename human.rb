class HumanPlayer
  attr_reader :name

  def initialize(_, name)
    @name = name
  end

  def guess
    puts "#{@name}, what is your letter?"
    gets.chomp
  end

  def alert_invalid_guess
    puts "Invalid letter"
  end
end
