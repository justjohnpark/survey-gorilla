get '/users/new' do
  # @user = User.new
  erb :"users/new"
end




post '/users' do
  password_conf = params[:password_conf]
  params.delete("password_conf")

  @user = User.new(params)

  if !(params[:password] != password_conf)
    @error = "Password and password confirmation must match"
  else
    if @user.save
      redirect '/'
    else
      @error = first_error(@user)
      erb :"users/new"
    end
  end
end

post '/login' do
  user = User.find_by_username(params[:username])
  if user && user.authenticate(params[:password])
    redirect '/surveys'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end
