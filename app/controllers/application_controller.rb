require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
	# enable sessions
	configure do
		register Sinatra::ActiveRecordExtension
		enable :sessions # turns sessions on
		set :session_secret, "my_application_secret" #encryption key that is used to create session_id
		set :views, Proc.new { File.join(root, "../views/") }
	end

	helpers do

		def logged_in?
			!!current_user #get boolean results
		end

		def current_user
			@current_user ||= User.find_by(:id => session[:id]) if session[:id]
		end

		def login(email, password)
			#is the user who they say they are?
			#check if user with this email exist
		  user = User.find_by(:email => email)
		  if user && user.authenticate(password)
		  	session[:id] = user.id
		  end	
		end
	end
end
