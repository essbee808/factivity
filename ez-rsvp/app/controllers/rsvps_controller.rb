class RsvpsController < ApplicationController

	post '/rsvp/:id' do 
		@event = Event.find_by("id" => params[:id])
		#binding.pry
		@user = User.find_by("id" => session[:id])
		if !@user.rsvps.find_by("user_id" => @user.id, "event_id" => @event.id)
			new_rsvp = Rsvp.create("user_id" => session[:id], "event_id" => @event.id)
			@user.rsvps << new_rsvp
			redirect to '/events/:id'
		else
			erb :'rsvp/error'
		end
	end

	delete '/rsvp/:id' do
		@user = User.find_by("id" => session[:id])
		@event = Event.find_by("id" => params[:id])
		remove_rsvp = @user.rsvps.select { |t| t.event_id == @event.id }
		@user.rsvps.delete(remove_rsvp)
		redirect to '/events/:id'
	end

		# post '/:id/rsvp' do
  #   	event = Event.find_by_id(params[:id])
  #   	binding.pry
  #   	
  #   end
end