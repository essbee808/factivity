class User < ActiveRecord::Base
	has_many :rsvps
	has_many :events, through: :rsvps
	has_secure_password

	validates :name, :email, :password, presence: true

end