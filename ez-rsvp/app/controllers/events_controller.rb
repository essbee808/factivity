class EventsController < ApplicationController

	get '/events' do 
		# renders page with upcoming events
		@events = Event.all
		erb :'events/index'
	end

	get '/events/new' do
		erb :'events/new'
	end

	post '/events' do
		@event = Event.new(:title => params[:event][:name], :location => params[:event][:location], :event_date => params[:event][:event_date], :start_time => params[:event][:start_time], :end_time => params[:event][:end_time])
		@event.save
		redirect to "/events"
	end

	get '/events/:id/edit' do
	end
end