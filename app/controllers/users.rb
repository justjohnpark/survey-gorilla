get '/users/new' do
  @user = User.new
  erb :"users/new"
end




post '/users' do
  password_conf = params[:password_conf]
  params.delete("password_conf")

  @user = User.new(params)

  if (params[:password] != password_conf)
    @error = "Password and password confirmation must match"
    erb :"users/new"
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
  puts params
  user = User.find_by_username(params[:username])
  if user && user.authenticate(params[:password])
    puts "IM HERER"
    redirect '/surveys'
  else
    redirect '/'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end
