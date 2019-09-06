require 'pry'

class UsersController < ApplicationController

 get '/' do
  if !logged_in? 
    erb :'index'
  else
    @user = User.find_by(:id => session[:id])
    erb :'users/show'
  end
 end

  get '/registrations/new' do
    if logged_in?
      redirect to '/'
    else
  	 erb :'users/registrations/new'
    end
  end  

  post '/registrations' do # collects login info
     #persist to database if user email does not exist
     existing_user = User.find_by(:email => params[:user][:email])

     @new_user = User.new(:email => params[:user][:email], :password => params[:user][:password], :name => params[:user][:name])
      if existing_user.nil? && @new_user.valid?
        @new_user.save
        session[:id] = @new_user.id
        redirect "/"
      else
        redirect "/registrations/new"
      end
  end

  post '/sessions/login' do
    user = login(params[:email], params[:password])
    if user != nil
      redirect to '/'
    else
      erb :'users/error'
    end
  end

  get '/failure' do
    if logged_in?
      redirect to '/'
    else
      erb :'users/registrations/error'
    end
  end

  get '/logout' do
  	#render logout page
    if !logged_in?
      redirect to '/'
    else
      session.clear
      session
    	erb :'/users/sessions/logout'
    end
  end

end