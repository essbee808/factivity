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

  post '/users' do
  	@user = User.create(params[:user])
  	binding.pry

  	erb :'users/show'
  end

  post '/login' do # 
  	binding.pry
  	@user = User.find_by(params[:id])
  	redirect to "/home"
  end

  get '/home' do 
  	@user = User.find_by(params[:id])
  	erb :'users/show'
  	# display events
  end

  get '/logout' do
  	# render logout page
  	redirect to "/login"
  end

end