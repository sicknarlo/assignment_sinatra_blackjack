require "sinatra"
require "./blackjack.rb"
require "sinatra/cookies"
require 'json'

# Root url



# helper do

# end


get '/' do 

  "<h1>Hello, world</h1>"

  erb :intro
  
end

get '/blackjack' do

  #gamestate = [cards, player hand, dealer hand]
  # gamestate = request.cookies["gamestate"]
  # cookies[:gamestate] = nil
  # gamestate = cookies["gamestate"]
  game = BlackJack.new([])
  @player_hand = game.player_hand
  
  gamestate = (game.update_game_state).to_json
  # response.set_cookie("gamestate",gamestate)
  cookies["gamestate"] = gamestate

  erb :blackjack 

end

post '/blackjack/hit' do

  #gamestate = [cards, player hand, dealer hand]
  @gamestate = cookies["gamestate"]

  game = BlackJack.new([JSON.parse(@gamestate)])
  game.hit
  @player_hand = game.player_hand
  @dealer_hand = game.dealer_hand
  @gamestate = (game.update_game_state).to_json
  
  cookies["gamestate"] = @gamestate

  erb :blackjack_hit

end