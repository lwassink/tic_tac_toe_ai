require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(mark)
    return true if @board.winner == other_mark(mark)
    return false if children.empty?

    if @next_mover_mark == mark
      children.all? { |child| child.losing_node?(mark)}
    else
      children.any? { |child| child.losing_node?(mark)}
    end
  end

  def winning_node?(mark)
    return true if @board.winner == mark
    return false if children.empty?

    if @next_mover_mark == mark
      children.any? { |child| child.winning_node?(mark)}
    else
      children.all? { |child| child.winning_node?(mark)}
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_positions.map do |pos|
      board = Board.new(deep_dup(@board.rows))
      board[pos] = @next_mover_mark
      TicTacToeNode.new(board,other_mark(@next_mover_mark),pos)
    end
  end

  def other_mark(mark)
    if mark == :x
      :o
    else
      :x
    end
  end


  def empty_positions
    all_positions.select {|position| @board.empty?(position)}
  end

  def all_positions
    [[0,0], [0,1], [0,2], [1,0], [1,1], [1,2], [2,0], [2,1], [2,2]]
  end

  def deep_dup(array)
    array.map do |row|
      row.dup
      # return el unless el.is_a?(Array)
      # deep_dup(el)
    end
  end
end
