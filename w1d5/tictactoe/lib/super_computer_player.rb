require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    if game.board.rows.flatten.compact.empty?
      return [1, 1]
    end

    node = TicTacToeNode.new(game.board, mark)

    possible_moves = node.children

    win_node = possible_moves.detect { |move| move.winning_node?(mark) }

    return win_node.prev_move_pos if win_node

    not_lose_node = possible_moves.detect do |move|
      !move.losing_node?(mark)
    end

    return not_lose_node.prev_move_pos if not_lose_node

    raise "I just can't win!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts 'Play the brilliant computer!'
  hp = HumanPlayer.new('Jeff')
  cp = SuperComputerPlayer.new

  p1, p2 = [hp, cp].shuffle
  TicTacToe.new(cp, hp).run
end
