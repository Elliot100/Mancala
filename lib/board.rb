require "byebug"

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1, @name2 = name1, name2  #player 1= name1  is on pos 6, player 2 = name2 is on pos 13
    @cups = Array.new(14) {[]}
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0..5).each do |i|
      4.times { @cups[i].push(:stone)}
    end
    (7..12).each do |i|
      4.times { @cups[i].push(:stone)}
    end
  end

  def valid_move?(start_pos)
    if start_pos > 13 || start_pos < 0
      raise p "Invalid starting cup"
    end

    if @cups[start_pos].length == 0 
      raise p "Starting cup is empty"
    end
    true
  end

  def make_move(start_pos, current_player_name)
      stones = @cups[start_pos].length
      @cups[start_pos] = []
      current_cup = start_pos + 1
      complete_round = false
      until stones == 0 && complete_round == true
        debugger
        unless current_player_name == @name1 && current_cup == 13 # other player cup
          @cups[current_cup].push(:stone) 
          stones -= 1
        end
        case current_cup 
        when 13
          complete_round = true if stones == 0 && @cups[current_cup].length == 1 #1 stone in the last position
          current_cup = 0 #rotates counter_clockwise
        else
          complete_round = true if stones == 0 && @cups[current_cup].length == 1 #1 stone in the last position
          current_cup += 1
        end
      end
  end
  

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
