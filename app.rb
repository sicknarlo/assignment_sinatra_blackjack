require "sinatra"
require "./blackjack.rb"
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
  gamestate = nil
  game = BlackJack.new
  player = game.player
  dealer = game.dealer


  gamestate = (game.update_game_state(game.cards, player.hand, dealer.hand)).to_json
  response.set_cookie("gamestate",gamestate)

  erb :blackjack 

end

post '/blackjack' do

  #gamestate = [cards, player hand, dealer hand]
  gamestate = request.cookies["gamestate"]

  game = BlackJack.new(JSON.parse(gamestate))
  player = game.player
  dealer = game.dealer


  player_choice = params[:player_action]

  player.hit(game.deal) if player_choice == "hit"

  @value = player.hand_value

  gamestate = (game.update_game_state(game.cards, player.hand, dealer.hand)).to_json
  response.cookies("gamestate",gamestate)

  erb :blackjack

end
  