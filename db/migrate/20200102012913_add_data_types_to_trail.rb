class AddDataTypesToTrail < ActiveRecord::Migration[6.0]
  def change
    change_table :trails do |t|
      t.string :trail_type
      t.string :summary
      t.string :difficulty
      t.float :rating
      t.float :longitude
      t.float :latitude
      t.integer :ascent
    end
  end
end
