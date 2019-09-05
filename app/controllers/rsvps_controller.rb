class RsvpsController < ApplicationController

	get '/rsvps' do #renders all events
		@user = User.find_by(:id => session[:id])
		if !logged_in?
			redirect to '/'
		elsif @user.rsvps.empty?
			erb :'rsvps/error'
		else
			erb :'rsvps/show'
		end
	end

	post '/rsvp/:id' do 
		@event = Event.find_by("id" => params[:id])
		@user = User.find_by("id" => session[:id])
		if params["yes"] == "Yes I'll be there"
			new_rsvp = Rsvp.create("user_id" => session[:id], "event_id" => @event.id)
			@user.rsvps << new_rsvp
			redirect to "/events/#{@event.id}"
		elsif params["no"] == "No thanks"
			redirect to "/events"
		end
	end

	
	delete '/rsvp/:id' do
		@user = User.find_by("id" => session[:id])
		@event = Event.find_by("id" => params[:id])
		rsvp = Rsvp.find_by("user_id" => @user.id, "event_id" => @event.id)
		rsvp.destroy
		redirect to "/events/#{@event.id}"
	end
end

