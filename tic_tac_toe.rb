class Tile
  attr_reader :symbol
  @@blank = " "

  def initialize
    @symbol = @@blank
    @occupied = false
  end

  def occupied?
    @occupied
  end

  def symbol=(symbol)
    @symbol = symbol
    @occupied = true
  end

end

class Player
  attr_reader :symbol, :name
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end
        
class Board
  attr_reader :tiles  
  def initialize
    @coords = [ :A1, :A2, :A3, :B1, :B2, :B3, :C1, :C2, :C3 ]
    @tiles =  Hash[@coords.map {|coord| [coord, Tile.new]}]  
    @win_lines = [[:A1, :A2, :A3], [:B1, :B2, :B3], [:C1, :C2, :C3],                        # Rows
                  [:A1, :B1, :C1], [:A2, :B2, :C2], [:A3, :B3, :C3],                        # Columns
                  [:A1, :B2, :C3], [:A3, :B2, :C1]]                                         # Diagnals
  end

  def display
    puts "   1   2   3 \n"  +                                                             #    1   2   3  
         "A  #{@tiles[:A1].symbol} | #{@tiles[:A2].symbol} | #{@tiles[:A3].symbol} \n" +  # A    |   |   
         "  ---|---|---\n" +                                                              #   ---|---|---
         "B  #{@tiles[:B1].symbol} | #{@tiles[:B2].symbol} | #{@tiles[:B3].symbol} \n" +  # B    |   |   
         "  ---|---|---\n" +                                                              #   ---|---|---
         "C  #{@tiles[:C1].symbol} | #{@tiles[:C2].symbol} | #{@tiles[:C3].symbol} \n"    # C    |   |   
  end

  def winner?(player_symbol)
    @win_lines.any? do |line| 
      line.map { |coord| @tiles[coord].symbol }.all? { |symbol| symbol == player_symbol }
    end
  end

  def make_move(player)
    valid_move = false
    puts "#{player.name}, please enter the coordinate where you would like to place an '#{player.symbol}'."
    until valid_move
      coord = gets.chomp.upcase.to_sym    
      next puts "#{coord} is not an option, please enter a valid coordintate" unless @tiles[coord]
      next puts "#{coord} is occupied, please enter another coordinate" if @tiles[coord].occupied?
      valid_move = true
    end
    @tiles[coord].symbol=(player.symbol)
  end
end

def new_game
  while true
    player_x, player_o = get_players
    game_board = Board.new
    game_board.display

    9.times do |turn_number|
      player = turn_number % 2 == 0 ? player_x : player_o
      game_board.make_move(player)
      game_board.display
      if game_board.winner?(player.symbol)
        puts "#{player.name} wins!"
        break
      end
    end

    puts "Enter 'y' to play again or anyting else to quit"
    gets.chomp.downcase == "y" ? next : break
  end
end

def get_players
  puts "Player 'X', enter your name:"
  player_x = Player.new(gets.chomp, :X)
  puts "Player 'O', enter your name:"
  player_o = Player.new(gets.chomp, :O)
  [player_x, player_o]
end

new_game

