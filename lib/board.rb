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
    other_store = get_other_store_idx(current_player_name)
    other_store == 13 ? current_store = 6 : current_store = 13

    stones = @cups[start_pos].length
    @cups[start_pos] = []
    current_cup = start_pos + 1

    until stones == 0
      unless current_cup == other_store
        @cups[current_cup].push(:stone) 
        stones -= 1
      end
      previous_cup = current_cup
      current_cup == 13? current_cup = 0 : current_cup += 1
      
    end

    render
    next_turn(previous_cup)

  end

  def get_other_store_idx(current_player)
    case current_player
    when @name1
      return 13
    else #@name2
      return 6
    end
  end
  

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    case ending_cup_idx
    when 6 
      return :prompt
    when 13
      return :prompt
    else
      if @cups[ending_cup_idx].length == 1 
        return :switch
      else
        return ending_cup_idx
      end
    end
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
