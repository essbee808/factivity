class EventsController < ApplicationController

	get '/events' do 
		# renders page with upcoming events
		@events = Event.all
		erb :'events/index'
	end

	get '/events/new' do #render new event page
		erb :'events/new'
	end

	post '/events' do # create and save new event to database
		existing_event = Event.find_by(:title => params[:event][:title], :location => params[:event][:location], :event_date => params[:event][:event_date])
		@event = Event.new(:title => params[:event][:title], :location => params[:event][:location], :event_date => params[:event][:event_date], :start_time => params[:event][:start_time], :end_time => params[:event][:end_time], :description => params[:event][:description], :creator_id => session[:id])
		@user = User.find_by(:id => session[:id])

		if existing_event.nil? && @event.valid?
			binding.pry
			user = User.find_by(:id => session[:id])
			@event.creator_id = user.id
			@event.save
			@events = Event.all
			redirect to "/events/#{@event.id}"
		elsif Event.all.include?(existing_event) == true
			#create error display page for duplicate events
			erb :'events/error'
		else
			redirect to "/events/new"
		end
	end

	get '/events/my-events' do 
		# renders page with events created by current user
		@user = User.find_by(:id => session[:id])
		if !@user.created_events.empty?
		  erb :'events/my-events'
		else	
		  redirect to "/events"
		end
	end

	get '/events/:id' do #get method renders event show page
		@event = Event.find_by(:id => params[:id].to_i)
		@user = User.find_by(:id => session[:id])
		@creator = User.find_by(:id => @event.creator_id)

		@rsvps = Rsvp.all
		@total_attending = []
		@new_rsvp = Rsvp.find_by(:user_id => @user.id, :event_id => @event.id)
		erb :'events/show'
	end

	get '/events/:id/edit' do
		@event = Event.find_by(:id => params["id"].to_i)
		if @event.creator_id == session[:id]
			erb :'events/edit'
		else
			redirect to "/events/#{@event.id}"
		end	
	end
 	
	patch '/events/:id' do #edit an event
		@event = Event.find_by_id(params[:id])
		@user = User.find_by(:id => session[:id])
		if @event.valid? && @user
			@event.update(params[:event])
			@event.save
		end
		redirect to "/events/#{@event.id}"
	end

	delete '/events/:id/delete' do #delete event created by user
		# user is only able to delete event from event list if user matches creator id
		@event = Event.find_by_id(params[:id])
		@all_rsvp = Rsvp.all 
		@all_rsvp.each do |el|
			if el.event_id == @event.id
				Rsvp.destroy(el)
			end
		end
		Event.destroy(@event)
		@events = Event.all
		redirect to '/events'
	end
end
