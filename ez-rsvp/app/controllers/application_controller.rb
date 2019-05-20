require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

  get '/users/new' do 
  	erb :'users/new'
  end

  get '/users/signin' do 
  	erb :'users/signin'
  end

  post '/users' do
  	@user = User.create(params[:user])
  	erb :'users/show'
  end


end
