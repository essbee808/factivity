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
		@event = Event.new(:title => params[:event][:title], :location => params[:event][:location], :event_date => params[:event][:event_date], :start_time => params[:event][:start_time], :end_time => params[:event][:end_time])
		if Event.find_by(:title => @event.title, :event_date => @event.event_date) == nil
			user = User.find_by("id" => session[:id])
			@event.user_id = user.id
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

	get '/events/:id' do 
		@event = Event.find_by(:id => params["id"].to_i)
		@user = User.find_by("id" => session[:id])
		erb :'events/show'
	end

	get '/my-events' do 
    	@user = User.find_by(:id => session[:id])
    	erb :'/events/my_events'
  	end

 	#edit and delete an event
	patch "/events/:id" do
		@event = Event.find_by_id(params[:id])
		binding.pry
		@event.update(params[:event])
		@event.save
		redirect to "/events/#{@event.id}"
	end

	delete '/events/:id' do
		# user is only able to delete event from event list if user matches creator id
		@event = Event.find_by_id(params[:id])
		@event.destroy
		redirect to '/events'
	end

end