class EventsController < ApplicationController

	get '/events' do 
		"Displays a list of upcoming events"
		@events = Event.all
		erb :'events/index'
	end

	post '/events' do

	end

	get '/events/:id/edit' do
	end
end