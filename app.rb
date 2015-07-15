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

  game = BlackJack.new([])

  update_player_hands(game)
  
  gamestate = (game.update_game_state).to_json

  cookies["gamestate"] = gamestate

  erb :blackjack 

end

post '/blackjack/hit' do

  #gamestate = [cards, player hand, dealer hand]
  @gamestate = cookies["gamestate"]

  game = BlackJack.new(JSON.parse(@gamestate))

  choice = params[:player_action]

  update_player_hands(game)

  if choice == "stay"
    redirect to("blackjack/stay")
  else
    game.hit
    update_player_hands(game)
    @player_value = player_bust?(@player_value)
  end
  @gamestate = (game.update_game_state).to_json
  
  cookies["gamestate"] = @gamestate

  erb :blackjack_hit

end

get '/blackjack/stay' do

  @gamestate = cookies["gamestate"]

  game = BlackJack.new(JSON.parse(@gamestate))
  update_player_hands(game)
  # @player_hand = game.player_hand
  # @dealer_hand = game.dealer_hand

  # @player_value = game.hand_value(@player_hand)
  # @dealer_value = game.hand_value(@dealer_hand)
  @outcome = game.dealer_playout
  
  erb :blackjack_stay

end
