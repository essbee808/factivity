require 'pry'

class UsersController < ApplicationController

 get '/' do
    if session[:id] == nil
      erb :'index'
    else
      @user = User.find_by(session[:id])
      redirect to "/homepage"
    end
 end

  get '/registrations/new' do 
  	erb :'users/registrations/new'
  end  

  post '/registrations' do # collects login info
  	@user = User.find_by(:email => params[:user][:email])
  	if @user
  		erb :'users/registrations/user_exists'
  	else
  		user = User.create(params[:user])
      redirect to "/success"
  	end 
  end

  post '/sessions/login' do
    @user = User.find_by(:email => params[:email], :password_digest => params[:password])
    if @user != nil
      @session = session
      @session[:id] = @user.id
      redirect to '/homepage'
    else
      erb :'users/error'
    end
    @session
  end

  get '/success' do
    erb :'users/registrations/confirmation'
  end

  get '/homepage' do
    @user = User.find_by(session[:id])
    erb :'users/home'
  end

  get '/home/:id' do 
  	@user = User.find(params[:id])
  	@events = Event.all
  	erb :'/users/show'
  end

  get '/logout' do
  	#render logout page
    session.clear
  	erb :'/users/sessions/logout'
  end

end