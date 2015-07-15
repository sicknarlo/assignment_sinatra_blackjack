require "sinatra"

# Root url
get '/' do 

  "<h1>Hello, world</h1>"

  erb :intro
  
end