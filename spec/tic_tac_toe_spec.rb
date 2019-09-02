require "./lib/tic_tac_toe.rb"

describe Tile do
  it "returns unocupied until symbol is set" do
    tile = Tile.new
    expect(tile.occupied?).to eq(false)
  end

  describe "#symbol=()" do
    it "returns occupied after symbol has been set" do
      tile = Tile.new
      tile.symbol=(:X)
      expect(tile.symbol).to eql(:X)
      expect(tile.occupied?).to eql(true)
    end
  end
end

describe Player do
  it "allows name and symbol to be read" do
    player = Player.new("Bob", :X)
    expect(player.name).to eql("Bob")
    expect(player.symbol).to eql(:X)
  end
end

describe Board do
  describe "#intialize" do
    it "creates hash of tiles stored by coordinate symbols" do
      board = Board.new
      expect(board.tiles[:B1].class).to eql(Tile)
      expect(board.tiles.values.all?{|tile| tile.class == Tile}).to be true
    end
  end

  describe "#winner?(player_symbol)" do
    it "checks if the given symbol has won" do
      board = Board.new
      [:A1, :A2, :A3].each {|coord| board.tiles[coord].symbol=(:X)}
      expect(board.winner?(:O)).to be false
      expect(board.winner?(:X)).to be true
    end

    it "checks for wins on diagnal" do
      board = Board.new
      [:A1, :B2, :C3].each {|coord| board.tiles[coord].symbol=(:O)}
      expect(board.winner?(:O)).to be true
      expect(board.winner?(:X)).to be false
    end
  end

  describe "#make_move(player)" do
    it "sets tile to player symbol" do
      player = Player.new("Bob", :O)
      board = Board.new
      allow(board).to receive(:gets).and_return("A1")
      board.make_move(player)
      expect(board.tiles[:A1].symbol).to eql(:O)
    end
  end
end

    