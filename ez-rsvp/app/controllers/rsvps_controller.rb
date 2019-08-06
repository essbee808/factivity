class RsvpsController < ApplicationController

	post '/rsvp/:id' do 
		binding.pry
		@event = Event.find_by("id" => params[:id])
		
		new_rsvp = Rsvp.create("users_id" => session[:id], "events_id" => @event.id)
		user = User.find_by("id" => session[:id])
		user.rsvps 
	end

		# post '/:id/rsvp' do
  #   	event = Event.find_by_id(params[:id])
  #   	binding.pry
  #   	
  #   end
end