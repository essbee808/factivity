require 'pry'

class UsersController < ApplicationController

 get '/' do
  #login(params[:email], params[:password])
  @user = User.find_by("id" => session[:id])
  erb :'index'
  if @user != nil
    erb :'users/show'
  else
    erb :'index'
  end
 end

  get '/registrations/new' do 
  	erb :'users/registrations/new'
  end  

  post '/registrations' do # collects login info
     #persist to database if user email does not exist
     existing_user = User.find_by(:email => params[:user][:email])
     @new_user = User.new(:email => params[:user][:email], :password => params[:user][:password_digest], :name => params[:user][:name])
      if existing_user == nil && @new_user.valid?
        @new_user.save
        session[:id] = @new_user.id
        redirect "/"
      else
        redirect "/registrations/new"
      end
  end

  post '/sessions/login' do
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:id] = user.id #session accessible everywhere
      redirect to '/'
    else
      erb :'users/error'
    end
  end

  get '/failure' do
    erb :'users/registrations/error'
  end

  get '/logout' do
  	#render logout page
    session.clear
    session
  	erb :'/users/sessions/logout'
  end

end