class AddCompleteStatusToHike < ActiveRecord::Migration[6.0]
  def change
    change_table :hikes do |t|
      t.boolean :completed
    end
  end
end
