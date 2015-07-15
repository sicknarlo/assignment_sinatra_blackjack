require './player'

class BlackJack

  attr_accessor :player_hand, :dealer_hand, :cards
  #can intialize with saved gamestate
  def initialize(game_state)
    @player_hand = []
    @dealer_hand = []
    
    #creates new game
    if game_state.empty?
      create_card_deck
      shuffle
      initial_deal
    else
      @game_state = game_state
      @player_hand = @game_state[0][1]
      @dealer_hand = @game_state[2]
      @cards = game_state[0]
    end

  end

  def initial_deal
    @player_hand << deal
    @player_hand << deal
    @dealer_hand << deal
    @dealer_hand << deal
  end

  #this will save in a session
  # Jsonify
  def update_game_state
    @game_state = [@cards, @player_hand, @dealer_hand]
  end

  def create_card_deck
    @cards = ["H", "C", "D", "S"].product(["A", 2, 3, 4, 5, 6, 
                                   7, 8, 9, 10, "J", "Q", "K"])
  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    @cards.pop
  end

  def hit
    @player_hand << deal
  end

end

