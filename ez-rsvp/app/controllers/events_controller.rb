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
		if !Event.all.find_by(:title => @event.title)
			@event.save
			@events = Event.all
			redirect to "/events"
		else
			#create error display page for duplicate events
			redirect to "/events/error"
		end
	end

	get "/events/error" do 
		erb :'events/error'
	end

	get "/events/:id" do 
		@event = Event.find_by_id(params[:id])
		erb :'events/show'
	end

	# get '/events/:id/edit' do
	# end
end