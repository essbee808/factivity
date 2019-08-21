class RsvpsController < ApplicationController

	post '/rsvp/:id' do 
		@event = Event.find_by("id" => params[:id])
		@user = User.find_by("id" => session[:id])
		if params["yes"] == "Yes"
		#if !@user.rsvps.find_by("user_id" => @user.id, "event_id" => @event.id) 
			new_rsvp = Rsvp.create("user_id" => session[:id], "event_id" => @event.id)
			@user.rsvps << new_rsvp
			 #redirect to add details to user's rsvp?
			redirect to "/events/#{@event.id}"
		else
			erb :'rsvp/error'
		end
	end

	delete '/rsvp/:id' do
		@user = User.find_by("id" => session[:id])
		@event = Event.find_by("id" => params[:id])
		rsvp = Rsvp.find_by("user_id" => @user.id, "event_id" => @event.id)
		rsvp.destroy
		redirect to "/my-events"
	end
end

