get '/login' do
  erb :'users/new'
end

get '/logout' do
  session[:user_id] = nil
  redirect "/"
end

delete '/logout' do
  session[:user_id] = nil
  redirect "/"
end

post '/users' do
  if params[:submit] == "create"
    @user = User.new(username: params[:username], password: params[:password])
    @user.save
    session[:user_id] = @user.id
    redirect "/"

  else
    # byebug
    if User.valid?(params[:username])
    user = User.where(username: params[:username]).first
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/"
      else
        flash[:notice] = "Wrong Password"
        erb :'users/new'
      end
    else
      flash[:notice] = "No such user exists"
      erb :'users/new'
    end
  end

end

