get '/surveys' do
  show_door
  if !current_user.taken_survey_ids.empty?
    @surveys = Survey.where(["creator_id != ? and id not in (?)", current_user.id, current_user.taken_survey_ids])
  else
    @surveys = Survey.where.not(creator_id: current_user.id)
  end
  erb :"surveys/index"
end

post '/surveys' do
  params[:creator_id] = current_user.id
  Survey.create_survey(params)
  redirect "/users/#{current_user.id}/surveys"
end

get '/surveys/new' do
  show_door
  erb :"surveys/new"
end

get '/surveys/:id' do
  show_door
  @survey = Survey.find_by_id(params[:id])
  @user_responses = current_user.find_responses_for @survey
  erb :"surveys/show"
end

get '/users/:user_id/surveys/:survey_id' do
  show_door
  @survey = Survey.find_by_id(params[:survey_id])
  redirect '/surveys' if @survey.respondents.include? current_user
  erb :"surveys/questions/index"
end

post '/surveys/:id' do
  show_door
  params[:respondent_id] = current_user.id
  Response.record_responses(params)
  redirect "/surveys/#{params[:id]}"
end



