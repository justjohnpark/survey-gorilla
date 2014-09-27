get '/surveys' do
  show_door
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
  show_door
  erb :"surveys/new"
end

get '/users/:id/surveys' do
  show_door
  @user = current_user
  @surveys = Survey.where(creator_id: current_user.id)
  erb :"users/surveys"
end

get '/surveys/:id' do
  show_door
  @survey = Survey.find_by_id(params[:id])
  # @user = User.find_by(id: session[:user_id])
  erb :"surveys/show"
end

get '/users/:user_id/surveys/:survey_id' do
  show_door
  @survey = Survey.find_by_id(params[:survey_id])
  erb :"surveys/questions/index"
end

post '/surveys/:id' do

  respondent_id = current_user.id
  survey_id = params[:id]
  params[:response].keys.each do |question_id|
    Response.create(respondent_id: respondent_id , survey_id: survey_id, question_id: question_id, choice_id: params[:response][question_id])
  end
  redirect "/surveys/#{survey_id}"
end
