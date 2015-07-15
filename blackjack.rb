require './player'

class BlackJack

  attr_accessor :player, :dealer, :cards
  #can intialize with saved gamestate
  def initialize(game_state=nil)
    
    #creates new game
    if game_state.nil?
      create_card_deck
      shuffle
      initial_deal
    else
      @game_state = game_state
      @player = Player.new([@game_state[1]])
      @dealer = Player.new([@game_state[2]])
    end

  end


  def initial_deal
    @player = Player.new([deal, deal])
    @dealer =Player.new([deal, deal])
  end
  #this will save in a session
  # Jsonify
  def update_game_state(cards, player_hand, dealer_hand)
    @game_state = [cards, player_hand, dealer_hand]
  end

  def create_card_deck
    @cards = ["H", "C", "D", "S"].product(["A", 2, 3, 4, 5, 6, 
                                   7, 8, 9, 10, "J", "Q", "K"])
  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    card = @cards.pop
  end

end

