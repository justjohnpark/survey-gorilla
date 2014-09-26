get '/surveys' do
  # @surveys = Survey.all
  erb :"surveys/index"
end

post '/surveys' do
  # erb :"surveys/new"
end

get '/surveys/new' do
  erb :"surveys/new"
end

get '/surveys/:id' do
  # @survey = Survey.find_by_id(params[:id])
  erb :"surveys/show"
end

get '/users/:id/surveys/:id' do
  erb :"surveys/questions/index"
end
