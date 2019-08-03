class AddCreatorToEventsTable < ActiveRecord::Migration
  def change
  	add_column :events, :creator, :integer
  end
end
