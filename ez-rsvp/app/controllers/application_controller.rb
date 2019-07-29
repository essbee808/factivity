require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
	configure do
		register Sinatra::ActiveRecordExtension
		enable :sessions # turns sessions on
		set :session_secret, "my_application_secret" #encryption key that is used to create session_id
		set :views, Proc.new { File.join(root, "../views/") }
	end

end
