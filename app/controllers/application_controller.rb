class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'
  
  # get '/' do
  #   { message: "Hello world" }.to_json
  # end

  get '/games' do
    # get all games from the database
    games = Game.all.order(:title).limit(10)
    # return a JSON response with an array of all the game data
    games.to_json
  end


  #use the :id syntax to create a dynamic route
  get '/games/:id' do
    #look up the game in the databse using its ID
    game = Game.find(params[:id])
    #send a JSON-formatted respone of the game data
    #include associated reviews in the JSON response
    #game.to_json(include: :reviews)
    #game.to_json(include: {reviews: { include: :user } })
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
