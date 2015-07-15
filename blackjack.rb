require './player'
require 'pry'

class BlackJack

  ROYALS = %W[K Q J]

  attr_accessor :player_hand, :dealer_hand, :cards, :game_state
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
      # binding.pry
      @game_state = game_state
      @player_hand = game_state[1]
      @dealer_hand = game_state[2]
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

  def hand_value(hand)

    value = 0
    aces = 0
    hand.each do |card|
      if ROYALS.include?(card[1])
        value += 10
      elsif card[1] == 'A'
        aces += 1
        if value + 11 > 21
          value += 1
        else
          value += 11
        end
      else
        value += card[1]
      end
    end
    if value > 21 || aces > 0
      until value <= 21 || aces == 0
        value -= 10
      end
    end
    value
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


    #dealer_value > player_value && <21
      #dealer_stays & wins
    #dealer_value > 21
      #dealer loses/busts
    #dealer_value >=17
      #dealer stays
    # else
      # dealer hits
  def game_over(dealer_value, player_value)
    if dealer_value > player_value && dealer_value < 21
      return "Dealer Wins"
    elsif dealer_value > 21
      return "Dealer Busts! Player Wins"
    elsif dealer_value >=17 && dealer_value > player_value
      return "Dealer Wins"
    elsif dealer_value >=17 && dealer_value < player_value
      return "Player Wins"
    else
      return nil
    end

  end
        

  def dealer_playout
    player_value = hand_value(@player_hand)
    dealer_value = hand_value(@dealer_hand)
    while game_over(dealer_value, player_value).nil?
      @dealer_hand<<deal
      dealer_value = hand_value(@dealer_hand)
    end
    game_over(dealer_value, player_value)
  end



end













