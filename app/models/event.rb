class Event < ActiveRecord::Base
	has_many :rsvps
	has_many :users, through: :rsvps

	validates :title, :location, :event_date, :start_time, :end_time, :user_id, :description, presence: true
end
