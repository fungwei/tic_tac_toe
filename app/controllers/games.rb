get '/games' do
  # Look in app/views/index.erb
   if session[:user_id] == nil
    redirect '/'
  else
    @users = User.where.not(id: session[:user_id])
    @active = Game.where(winner_id: nil).where(loser_id: nil).where("player1_id = ? OR player2_id = ?", session[:user_id], session[:user_id])
    @win = Game.where(winner_id: session[:user_id]).count
    @lose = Game.where(loser: session[:user_id]).count
    erb :'games/index'
  end
end

post '/games' do
  # Look in app/views/index.erb
  game = Game.new(player1_id: session[:user_id], player2_id: params[:player2_id])
  if game.save
  redirect "/games/#{game.id}"
  end
end

get '/games/:id' do
  if session[:user_id] == nil
    redirect '/'
  else
    @state = []
    @game_id = params[:id]
    @user_id = session[:user_id]
    @game = Game.find(@game_id)
    if session[:user_id] == @game.player1_id
      @hover = "hover_x"
      @player = 1
    else
      @hover = "hover_o"
      @player = 2
    end

    @state = Game.get_state(@game)

    # puts @state[1]
    # puts @hover


    erb :'games/show'
  end
end

post '/games/:id' do
  user_id = session[:user_id]
  position = params[:position]
  game = Game.find(params[:id])

  move = game.moves.new(user_id: user_id, move: position)
  state = []
  if move.save

   state = Game.get_state(game)
  end
  state.to_json


end

get '/games/:id/poll' do
  user_id = session[:user_id]
  game = Game.find(params[:id])


  state = Game.get_state(game)
  state.to_json


end