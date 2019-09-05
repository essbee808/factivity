class CreateEvents < ActiveRecord::Migration
  def change
  	create_table :events do |t|
      	t.string :title
  		t.string :location
  		t.date :event_date
  		t.string :start_time
  		t.string :end_time
  		t.text :description
  		t.integer :creator_id
  	end
  end
end
