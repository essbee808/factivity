class CreateRsvpTable < ActiveRecord::Migration
  def change
  	create_table :rsvps do |t|
  		 t.belongs_to :user, index: true
  		 t.belongs_to :event, index: true
  	end
  end
end
