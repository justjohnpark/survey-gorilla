get '/surveys' do
  @surveys = Survey.all
  erb :"surveys/index"
end

post '/surveys' do
  survey_title = params[:title]
  all_questions = params[:questions]

  survey = Survey.create(title: params[:title], creator_id: current_user.id)

  all_questions.each_value do |value|
    question_text = value[:question]
    all_choices = value[:options]

    question = Question.create(content: question_text, survey_id: survey.id)

    all_choices.each_value do |value|
      Choice.create(content: value, question_id: question.id)
    end
  end

  redirect "/users/#{current_user.id}/surveys"
end

get '/surveys/new' do
  erb :"surveys/new"
end

get '/users/:id/surveys' do
  @user = current_user
  @surveys = Survey.where(creator_id: current_user.id)
  erb :"users/surveys"
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

