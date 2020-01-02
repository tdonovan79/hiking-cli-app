class AddLocationIdToTrails < ActiveRecord::Migration[6.0]
  def change
    change_table :trails do |t|
      t.integer :location_id
    end
  end
end
