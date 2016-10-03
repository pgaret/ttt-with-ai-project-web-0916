require 'pry'

class Board

  attr_accessor :cells

  def initialize
    @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def reset!
    @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display
    print "\n-----------\n"
    for i in 0..8
      if i % 3 == 0 || i % 3 == 2 then print " #{cells[i]} "
      elsif i % 3 == 1 then print "| #{cells[i]} |" end
      if i % 3 == 2 then print "\n-----------\n" end
    end
  end

  def update(position, player)
    @cells[position.to_i - 1] = player.token
  end

  def position(input)
    @cells[input.to_i - 1]
  end

  def full?
    !cells.include?(" ")
  end

  def turn_count
    @cells.select{|cell| cell != " "}.count
  end

  def taken?(space)
    position(space) != " "
  end

  def valid_move?(space)
    if space.to_i > 0 && space.to_i < 10 && !taken?(space) then true
    else false end
  end

end
