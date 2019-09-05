class User < ActiveRecord::Base
	has_many :rsvps
	has_many :created_events, foreign_key: "creator_id", class_name: "Event"
	has_many :events, through: :rsvps
	has_secure_password

	validates :name, :email, :password, presence: true
end