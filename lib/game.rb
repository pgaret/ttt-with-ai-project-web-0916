class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Array.new(9, " "))
    if board.class == Board then @board = board
    else @board = Board.new end
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    if @board.cells.select{|pieces| pieces != " "}.count % 2 == 0 then @player_1
    else @player_2 end
  end

  def cell_data(index)
    if @board.cells[index].include?("X") then "X"
    elsif @board.cells[index].include?("O") then "O"
    else " "
    end
  end

  def over?
    if draw? || won? then true
    else false end
  end

  def draw?
    if @board.full? && !won? then true
    else false end
  end

  def get_winning_token
    WIN_COMBINATIONS.each do |winner|
      if cell_data(winner[0]) != " " && cell_data(winner[0]) == cell_data(winner[1]) && cell_data(winner[1]) == cell_data(winner[2]) then
        return cell_data(winner[0])
      end
    end
    nil
  end

  def won?
    if get_winning_token != nil then true
    else false end
  end

  def winner
    if won? then get_winning_token
    else nil end
  end

  def take_turn_input
    input = current_player.move(@board)
    while input.to_i < 1 || input.to_i > 9
      if @board.taken?(input) then input = -1 end
      puts "invalid"
      input = current_player.move(@board)
    end
    @board.update(input, current_player)
  end

  def turn
    take_turn_input
    @board.display
    if current_player == @player_1 then current_player = @player_2
    else current_player = @player_1 end
  end

  def play
    while !over?
      puts "Please input your move, 1-9: "
      turn
    end
    if won? then puts "Congratulations #{winner}!"
    elsif draw? then puts "Cats Game!" end
  end

end
