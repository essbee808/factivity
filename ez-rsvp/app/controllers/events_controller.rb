class EventsController < ApplicationController

	get '/events' do 
		# renders page with upcoming events
		@events = Event.all
		erb :'events/index'
	end

	post '/events' do

	end

	get '/events/:id/edit' do
	end
end