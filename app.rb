require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'
require_relative 'models/question'
require_relative 'models/user'

enable: session

get '/' do
  @questions = Question.all
  erb :index
end

get '/questions/new' do
  erb :questions_new
end

post '/questions' do
  question = Question.new
  question.content = params[:content]

  if question.save
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
  user.password_digest = params[:password]

  if user.save
    redirect to '/'
  else
    erb :users_new
  end
end
