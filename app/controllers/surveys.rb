get '/surveys' do
  @surveys = Survey.all
  erb :"surveys/index"
end

post '/surveys' do
  puts params
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

get '/surveys/:id' do
  @survey = Survey.find_by_id(params[:id])
  erb :"surveys/show"
end

get '/users/:id/surveys/:id' do
  erb :"surveys/questions/index"
end
