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
    #binding.pry
  	@user = User.find_by(:email => params[:user][:email])
  	if @user
  		erb :'users/user_exists'
  	else
  		user = User.create(params[:user])
      redirect to "/success"
  	end
  end

  get '/success' do
    erb :'users/confirmation'
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