get '/games' do
  # Look in app/views/index.erb
   if session[:user_id] == nil
    redirect '/'
  else
    @users = User.where.not(id: session[:user_id])
    @active = Game.where(winner_id: nil).where(loser_id: nil).where("player1_id = ? OR player2_id = ?", session[:user_id], session[:user_id])
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
    @game_id = params[:id]
    @user_id = session[:user_id]
    @game = Game.find(@game_id)
    if session[:user_id] == @game.player1_id
      @hover = "hover_x"
    else
      @hover = "hover_o"
    end

    count = 1
    @state = []
    9.times do
      if @game.moves.find_by(move: count.to_s) != nil
        if @game.moves.find_by(move: count.to_s).user_id == @game.player1_id
          @state[count] = "player1_x"
        elsif @game.moves.find_by(move: count.to_s).user_id == @game.player2_id
          @state[count] = "player2_o"
        end
      else
        @state[count] = "none"
      end
      count += 1
    end



    erb :'games/show'
  end
end

post '/games/:id' do
  user_id = session[:user_id]
  position = params[:position]
  game = Game.find(params[:id])

  move = game.moves.new(user_id: user_id )
  if move.save

    erb :'games/show'
  end
end