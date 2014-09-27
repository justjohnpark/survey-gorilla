User.delete_all
Survey.delete_all
Question.delete_all
Choice.delete_all
Response.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('surveys')
ActiveRecord::Base.connection.reset_pk_sequence!('questions')
ActiveRecord::Base.connection.reset_pk_sequence!('choices')
ActiveRecord::Base.connection.reset_pk_sequence!('responses')

User.create(username: "TromboneMan89", password: "ilovebrass")
User.create!(username: "inoda", password: "stylin")

Survey.create(title: "Horns", creator_id: 1)

Question.create(content: "What is your favorite brass instrument?", survey_id: 1)
Question.create(content: "Can you play a harp?", survey_id: 1)
Question.create(content: "What is your favorite symphony orchestra?", survey_id: 1)

Choice.create(content: "Tuba", question_id: 1)
Choice.create(content: "French Horn", question_id: 1)
Choice.create(content: "Euphonium", question_id: 1)
Choice.create(content: "Trombone", question_id: 1)
Choice.create(content: "Yes", question_id: 2)
Choice.create(content: "No", question_id: 2)
Choice.create(content: "Chicago Symphony Orchestra", question_id: 3)
Choice.create(content: "Cleveland Symphony Orchestra", question_id: 3)
Choice.create(content: "Kansas City Symphony Orchestra", question_id: 3)
Choice.create(content: "St. Louis Symphony Orchestra", question_id: 3)

Response.create(respondent_id: 2, survey_id: 1, choice_id: 4, question_id: 1)
Response.create(respondent_id: 2, survey_id: 1, choice_id: 6, question_id: 2)
Response.create(respondent_id: 2, survey_id: 1, choice_id: 7, question_id: 3)

