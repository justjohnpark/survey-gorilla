get '/surveys' do
  @surveys = Survey.all
  erb :"surveys/index"
end

post '/surveys' do
  survey_title = params[:title]
  all_questions = params[:questions]

  puts survey_title

  all_questions.each do |key, value|
    question = value[:question]
    all_options = value[:options]

    puts "QUESTION #{question}"

    all_options.each do |key, value|
      puts "OPTION #{value}"
    end
  end

  redirect "/users/:id/surveys"
end

get '/john' do
  erb :"surveys/questions/index"
end

post '/john' do
  puts params
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
