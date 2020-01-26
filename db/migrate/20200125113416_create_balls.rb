class CreateBalls < ActiveRecord::Migration[6.0]
  def change
    create_table :balls do |t|
      t.references :game, foreign_key: true, index: true
      t.integer :frame, limit: 1
      t.integer :roll, limit: 1
      t.integer :knocked_pins, limit: 1
      t.timestamps
    end
  end
end
