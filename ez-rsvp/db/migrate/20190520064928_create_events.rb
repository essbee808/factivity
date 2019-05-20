class CreateEvents < ActiveRecord::Migration
  def change
  	create_table :events do |t|
  		t.string :title
  		t.string :location
  		t.date :event_date
  		t.time :start_time
  		t.time :end_time
  	end
  end
end
