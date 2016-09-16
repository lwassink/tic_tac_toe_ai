require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    
    winner = children.find { |child| child.winning_node?(mark) }
    return winner.prev_move_pos unless winner.nil?

    children.find { |child| !child.losing_node?(mark) }.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
