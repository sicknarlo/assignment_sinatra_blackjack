require "sinatra"
require "./blackjack.rb"
require "sinatra/cookies"
require 'json'
require 'pry'
require './helpers/helpers.rb'

helpers UpdateHands

get '/' do 

  "<h1>Hello, world</h1>"

  erb :intro
  
end

get '/blackjack' do
  if cookies["bankroll"].nil?
    @bankroll = 1000
  else
    @bankroll = cookies["bankroll"].to_i
  end

  game = BlackJack.new([])

  @bankroll -= 10

  update_player_hands(game)
  
  gamestate = (game.update_game_state).to_json

  cookies["bankroll"] = @bankroll
  cookies["gamestate"] = gamestate

  erb :blackjack 

end

post '/blackjack/hit' do

  #gamestate = [cards, player hand, dealer hand]
  @gamestate = cookies["gamestate"]
  @bankroll = cookies["bankroll"].to_i

  game = BlackJack.new(JSON.parse(@gamestate))

  choice = params[:player_action]

  #updates player/dealer card values
  update_player_hands(game)

  if choice == "stay"
    redirect to("blackjack/stay")
  else
    #hit adds random card to player's card hand
    game.hit
    update_player_hands(game)
    #if player busts, updates player value to "BUST"
    @player_value = player_bust?(@player_value)
    redirect to("blackjack/stay") if @player_value == "BUST"
  end

  @gamestate = (game.update_game_state).to_json
  
  cookies["gamestate"] = @gamestate
  cookies["bankroll"] = @bankroll

  erb :blackjack

end

get '/blackjack/stay' do

  @gamestate = cookies["gamestate"]
  @bankroll = cookies["bankroll"].to_i

  game = BlackJack.new(JSON.parse(@gamestate))
  update_player_hands(game)

  if game.hand_value(@player_hand) > 21
    @outcome = "Player Busts"
  else
    @outcome = game.dealer_playout
    unless @outcome.include?("Dealer Wins")
      @bankroll += 20
    end
  end

  cookies["bankroll"] = @bankroll
  erb :blackjack_stay

end
