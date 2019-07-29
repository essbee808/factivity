require 'pry'

class UsersController < ApplicationController

 get '/' do
    #binding.pry
    if session
      redirect to '/users/home'
    else
    	erb :index
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
      @session[:user_id] = @user.id
      redirect '/users/home'
    else
      erb :'users/error'
    end
  end

  get '/success' do
    erb :'users/registrations/confirmation'
  end

  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end

  get '/home/:id' do 
  	@user = User.find(params[:id])
  	@events = Event.all
  	erb :'/users/show'
  end

  get '/sessions/logout' do
  	#render logout page
    binding.pry
  	session.clear
  	redirect to "/"
  end

end