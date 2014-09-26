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

get '/surveys/new' do
  erb :"surveys/new"
end

get '/surveys/:id' do
  @survey = Survey.find_by_id(params[:id])
  @user = User.find_by(id: session[:user_id])
  erb :"surveys/show"
end

get '/users/:user_id/surveys/:survey_id' do
  @survey = Survey.find_by_id(params[:survey_id])
  erb :"surveys/questions/index"
end


post '/surveys/:id' do
  respondent_id = nil #change to current_user.id on git merge
  survey_id = params[:id]
  params[:response].keys.each do |question_id|
    Response.create(respondent_id: respondent_id , survey_id: survey_id, question_id: question_id, choice_id: params[:response][question_id])
  end
  redirect 'surveys/:id'
end

