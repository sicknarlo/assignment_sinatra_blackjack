require "sinatra"
require "./blackjack.rb"

# Root url



# helper do

# end


get '/' do 

  "<h1>Hello, world</h1>"

  erb :intro
  
end

get '/blackjack' do

  cards = BlackJack.new
  # cards.shuffle
  @player_hand = cards.deal
  @dealer_hand = cards.deal

  erb :blackjack 

end

post '/blackjack' do

  player_choice = params[:player_action]
  