get '/' do
  if logged_in?
    redirect '/surveys'
  else
    @homepage = true
    erb :index
  end
end
