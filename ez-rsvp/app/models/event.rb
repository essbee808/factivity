class Event < ActiveRecord::Base
	belongs_to :user
	has_many :user_events
	has_many :users, through: :user_events
end
