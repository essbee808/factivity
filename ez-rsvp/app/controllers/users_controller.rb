class UsersController < ApplicationController

 get '/' do
    erb :index
 end

 get '/login' do # existing user will login
  	"Hello"
 end

 get '/register' do #create new user
  	erb :'/users/new'
 end

 post "/homepage" do
  	
 end

end