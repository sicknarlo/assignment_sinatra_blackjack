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
  request.cookies["gamestate"]

  game = BlackJack.new(JSON.parse(gamestate))
  player = Player.new(game.game_state[1])
  dealer = Player.new(game.game_state[2])

  # game.shuffle
  @player_hand = pl
  @dealer_hand = game.deal

  gamestate = (game.update_game_state(game.cards, player.hand, dealer.hand)).to_json
  response.cookies("gamestate",gamestate)

  erb :blackjack 

end

post '/blackjack' do

  #gamestate = [cards, player hand, dealer hand]
  request.cookies["gamestate"]

  game = BlackJack.new(JSON.parse(gamestate))
  player = Player.new(game.game_state[1])
  dealer = Player.new(game.game_state[2])

  player_choice = params[:player_action]

  player.hit(game.deal) if player_choice = "hit"

  gamestate = (game.update_game_state(game.cards, player.hand, dealer.hand)).to_json
  response.cookies("gamestate",gamestate)

end
  