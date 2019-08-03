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
		binding.pry
		@event = Event.new(:title => params[:event][:title], :location => params[:event][:location], :event_date => params[:event][:event_date], :start_time => params[:event][:start_time], :end_time => params[:event][:end_time], :creator => session[:id])
		if Event.find_by(:title => @event.title) == nil
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

	get '/events/:id/edit' do
		#binding.pry
		@event = Event.find_by(:id => params["id"].to_i)
		erb :'events/edit'
	end

	get "/events/:id" do 
		@event = Event.find_by(:id => params["id"].to_i)
		erb :'events/show'
	end

	patch "/events/:id" do
		#binding.pry
		@event = Event.find_by_id(params[:id])
		@event.title = params[:event][:title]
		@event.location = params[:event][:location]
		@event.event_date = params[:event][:event_date]
		@event.start_time = params[:event][:start_time]
		@event.end_time = params[:event][:end_time]

		@event.save
		redirect to "/events/#{@event.id}"
	end

	

	post '/events/:id' do

	end

	delete '/events/:id/delete' do
		# user is only able to delete event from event list if user matches creator id
		binding.pry
		@event = Event.find_by_id(params[:id])
		@event.delete
	end

	# create route for association
end