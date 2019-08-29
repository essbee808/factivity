class EventsController < ApplicationController

	get '/events' do 
		# renders page with upcoming events
		#@user = User.find_by("id" => session[:id])
		@events = Event.all
		erb :'events/index'
	end

	get '/events/new' do #render new event page
		erb :'events/new'
	end

	post '/events' do # create and save new event to database
		@event = Event.new(:title => params[:event][:title], :location => params[:event][:location], :event_date => params[:event][:event_date], :start_time => params[:event][:start_time], :end_time => params[:event][:end_time])
		if Event.find_by(:title => @event.title, :event_date => @event.event_date) == nil
			user = User.find_by(:id => session[:id])
			@event.user_id = user.id
			@event.save
			@events = Event.all
			redirect to "/events/#{@event.id}"
		else
			#create error display page for duplicate events
			redirect to "/events/error"
		end
	end

	get '/my-events' do 
		@user = User.find_by(:id => session[:id])
		@events = Event.all
		erb :'events/my-events'
	end

	get '/events/:id/edit' do
		@event = Event.find_by(:id => params["id"].to_i)
		erb :'events/edit'
	end

	get '/events/:id' do #renders event show page
		@event = Event.find_by(:id => params[:id].to_i)
		@user = User.find_by(:id => session[:id])
		@creator = User.find_by(:id => @event.user_id)
		erb :'events/show'
	end

  	get '/events/error' do
  		erb :'events/error'
  	end
 	
	patch "/events/:id" do #edit an event
		@event = Event.find_by_id(params[:id])
		@event.update(params[:event])
		@event.save
		redirect to "/events/#{@event.id}"
	end

	delete '/events/:id' do #delete event created by user
		# user is only able to delete event from event list if user matches creator id
		# rsvps = Rsvp.find_by(:event_id => 4)
		# rsvps = Rsvp.select(:event_id => 4)
		@event = Event.find_by_id(params[:id])
		@event.destroy
		redirect to '/events'
	end
end