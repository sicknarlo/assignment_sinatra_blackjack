require "sinatra"
require "./blackjack.rb"
require "sinatra/cookies"
require 'json'
require 'pry'

# Root url



# helper do

# end


get '/' do 

  "<h1>Hello, world</h1>"

  erb :intro
  
end

get '/blackjack' do

  game = BlackJack.new([])
  @player_hand = game.player_hand
  
  # binding.pry 
  
  gamestate = (game.update_game_state).to_json
  # response.set_cookie("gamestate",gamestate)
  cookies["gamestate"] = gamestate

  erb :blackjack 

end

post '/blackjack/hit' do

  #gamestate = [cards, player hand, dealer hand]
  @gamestate = cookies["gamestate"]

  # binding.pry
  game = BlackJack.new(JSON.parse(@gamestate))
  game.hit
  @player_hand = game.player_hand
  @player_value = game.hand_value(@player_hand)
  if @value > 21
    @value = "BUST"
  else
    @value
  end
  @dealer_hand = game.dealer_hand
  @gamestate = (game.update_game_state).to_json
  
  cookies["gamestate"] = @gamestate

  erb :blackjack_hit

end

get '/blackjack/stay' do

  @gamestate = cookies["gamestate"]

  game = BlackJack.new(JSON.parse(@gamestate))
  @player_value = game.hand_value(@player_hand)
  @dealer_value = game.hand_value(@dealer_hand)
  

end










