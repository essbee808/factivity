class CreateRsvpTable < ActiveRecord::Migration
  def change
  	create_table :rsvps do |t|
  		 t.belongs_to :users, index: true
  		 t.belongs_to :events, index: true
  	end
  end
end
