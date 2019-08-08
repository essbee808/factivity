class RsvpsController < ApplicationController

	post '/rsvp/:id' do 
		@event = Event.find_by("id" => params[:id])
		#binding.pry
		@user = User.find_by("id" => session[:id])
		if !@user.rsvps.find_by("user_id" => @user.id, "event_id" => @event.id)
			new_rsvp = Rsvp.create("user_id" => session[:id], "event_id" => @event.id)
			@user.rsvps << new_rsvp
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
		binding.pry
		redirect to "/events/#{@event.id}"
	end

end