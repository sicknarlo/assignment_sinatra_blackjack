
class BlackJack

  #can intialize with saved gamestate
  def initialize(game_state = [])
    @game_state = game_state

    #creates new game
    if @game_state.empty?
      create_card_deck
      shuffle
    end

  end

  #this will save in a session
  # Jsonify
  def update_game_state(player_hand, dealer_hand)
    @game_state = [@cards, player_hand, dealer_hand]
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

