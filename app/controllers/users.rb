get '/users/new' do
  @user = User.new
  erb :"users/new"
end

get '/users/:id/surveys' do
  show_door
  @surveys = current_user.created_surveys
  erb :"users/surveys/index"
end

get '/users/:id/responses' do
  show_door
  @surveys = current_user.taken_surveys
  erb :"users/responses/index"
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
  user = User.find_by_username(params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/surveys'
  else
    redirect '/'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end
