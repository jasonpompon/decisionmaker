require 'sinatra'
require_relative 'db_config'
require_relative 'models/question'
require_relative 'models/user'
require_relative 'models/answer'
require_relative 'models/user_vote'
require 'pry'

enable :sessions

helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

end

get '/' do
  @questions = Question.all
  erb :index
end

get '/questions/new' do
  redirect to '/session/new_question' unless logged_in?
  erb :questions_new
end

post '/questions' do
  question = Question.new
  question.content = params[:content]
  question.user_id = current_user.id
  if question.save

# add the rest here
    answers = [params[:option1], params[:option2]]

    answers.each do |option|
      newAnswer = Answer.new
      answer1.option = params[option]
      answer1.question_id = question.id
      answer.save
    end
    #
    # answer1 = Answer.new
    # answer1.option = params[:option1]
    # answer1.question_id = question.id
    # # answer1.vote = 0
    # answer1.save
    # answer2 = Answer.new
    # answer2.option = params[:option2]
    # answer2.question_id = question.id
    # # answer2.vote = 0
    # answer2.save
    # answer3 = Answer.new
    # answer3.option = params[:option3]
    # answer3.question_id = question.id
    # # answer3.vote = 0
    # answer3.save
    # answer4 = Answer.new
    # answer4.option = params[:option4]
    # answer4.question_id = question.id
    # # answer4.vote = 0
    # answer4.save
    redirect to '/'
  else
    erb :questions_new
  end
end

get '/users/new' do
  erb :users_new
end

post '/users' do
  user = User.new
  user.username = params[:username]
  user.email = params[:email]
  user.password = params[:password]
  if user.save
    redirect to '/'
  else
    erb :users_new
  end
end


get '/session/new' do
  erb :sessions_new
end

post '/session' do
  user = User.find_by(username: params[:username])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/'
  else
    erb :sessions_new
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect to '/session/new'
end

get '/questions/:id' do
  @question = Question.find(params[:id])
  @answers = Answer.where(question_id: @question.id).order('id')
  @user = User.find(@question.user_id)
  erb :questions_show
end

delete '/questions/:id' do
  question = Question.find(params[:id])
  question.destroy
  answers = Answer.where(question_id: question.id)
  answers.each do |answer|
   answer.destroy
  end
  redirect to '/'
end

get '/users/:id' do
  @user = User.find(params[:id])
  @questions = Question.where(user_id: params[:id])
  erb :users_show
end

post '/questions/:id' do
  redirect to '/session/new_vote' unless logged_in?
  question = Question.find(params[:id])
  answer = Answer.where(question_id: question.id)
  option = answer.find_by(id: params[:option])
  option.update(vote: (option.vote + 1))
  # if
  user = User_vote.new
  user.user_id = current_user.id
  user.answer_id = option.id
  user.save
  redirect to "/questions/#{params[:id]}"
end

get '/session/new_question' do
  erb :sessions_new_question
end

post '/session_question' do
  user = User.find_by(username: params[:username])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/questions/new'
  else
    erb :sessions_new
  end
end

get '/session/new_vote' do
  erb :sessions_vote
end

post '/session_vote' do
  user = User.find_by(username: params[:username])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/'
  else
    erb :sessions_new
  end
end

get '/how_it_works' do
  erb :about
end

# still left TODO:
# 4 don't let a user to vote more than onece on a question
