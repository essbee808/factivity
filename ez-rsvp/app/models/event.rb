class Event < ActiveRecord::Base
	has_many :rsvps
	has_many :users, through: :rsvps
end
