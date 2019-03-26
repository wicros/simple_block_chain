class CreateBlockTable < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
      t.string :current_hash, null: false
      t.string :previous_hash, null: false
      t.datetime :timestamp, null: false
      t.integer :difficulty, null: false, default: 0
      t.integer :nonce, null: false


      t.timestamps
      t.index :current_hash, unique: true
    end
  end
end
