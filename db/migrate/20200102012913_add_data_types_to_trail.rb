class AddDataTypesToTrail < ActiveRecord::Migration[6.0]
  def change
    change_table :trails do |t|
      t.string :type
      t.string :summary
      t.string :difficulty
      t.integer :rating
      t.float :longitude
      t.float :lattitude
      t.integer :ascent
    end
  end
end
