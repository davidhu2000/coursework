require 'byebug'
class ComputerPlayer
  attr_reader :name

  def initialize(name = "Computer")
    @name = name
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @fragment = ''
  end

  def guess
    if @fragment.empty?
      ltr = @dictionary.sample[0]
      puts "#{@name} guesses #{ltr}"
      return ltr
    end

    possible_words = @dictionary.select do |word|
      word =~ /^#{@fragment}/
    end

    possible_words = possible_words.to_a.sort.reverse

    possible_guesses = possible_words.map do |word|
      word[@fragment.length]
    end

    possible_guesses.each do |ltr|
      frag_check = @fragment + ltr
      words = possible_words.select { |word| word =~ /^#{frag_check}/ }
      if words.length == 1 && (words.length - frag_check.length).odd?
        puts "#{@name} guesses #{ltr}"
        return ltr
      end
    end

    ltr = possible_words.sample[@fragment.length]

    while @dictionary.include? "#{@fragment + ltr}" && possible_words.length > 1
      ltr = possible_words.sample[@fragment.length]
    end
    puts "#{@name} guesses #{ltr}"
    ltr
  end

  def alert_invalid_guess
    puts "Invalid letter"
  end

  def receive_fragment(fragment)
    @fragment = fragment
  end
end
