class Event < ActiveRecord::Base
	belongs_to :creator, class_name: "User"
	has_many :rsvps
	has_many :users, through: :rsvps

	validates :title, :location, :event_date, :start_time, :end_time, :description, :creator_id, presence: true
end
