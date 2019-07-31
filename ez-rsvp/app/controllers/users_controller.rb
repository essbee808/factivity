require 'pry'

class UsersController < ApplicationController

 get '/' do
  erb :'index'
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
    elsif @user == nil
      erb :'users/error'
    end
    @session
  end

  get '/success' do
    erb :'users/registrations/confirmation'
  end

  get '/homepage' do
    binding.pry
    @user = User.find_by(session[:id])
    if @user
      erb :'users/home'
    else
      redirect to "/"
    end
    
  end

  get '/home/:id' do 
  	@user = User.find(params[:id])
  	@events = Event.all
  	erb :'/users/show'
  end

  get '/logout' do
  	#render logout page
    #binding.pry
    session.clear
    session
  	erb :'/users/sessions/logout'
  end

end