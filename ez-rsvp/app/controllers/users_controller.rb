require 'pry'

class UsersController < ApplicationController

 get '/' do
  	erb :index
  end

  get '/login' do 
  	erb :'users/login'
  end

  get '/register' do 
  	erb :'users/new'
  end  

  post '/register' do # collects login info
  	@user = User.find_by(:email => params[:user][:email])
  	if @user != nil
  		erb :'users/user_exists'
  	else
  		@user = User.create(params[:user])
  		redirect to "/login"
  	end
  end

  post '/login' do
  	@user = User.find_by(:email => params[:email])
  	if @user && (@user.password_digest == params[:password])
  		session[:user_id] = @user.id
 		redirect to "/home/#{@user.id}"
  	else
  		erb :'users/error'
  	end
  end

  get '/home/:id' do 
  	@user = User.find(params[:id])
  	@events = Event.all
  	erb :'/users/show'
  end

  get '/logout' do
  	# render logout page
  	session.clear
  	redirect to "/"
  end

end