
module UpdateHands

  def update_player_hands(game)
    @player_hand = game.player_hand
    @player_value = game.hand_value(@player_hand)
    @dealer_hand = game.dealer_hand
    @dealer_value = game.hand_value(@dealer_hand)
  end

  def player_bust?(player_value)
    if player_value > 21
      player_value = "BUST"
    else
      player_value
    end
    player_value
  end

end