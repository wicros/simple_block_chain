class CreateTranscationTable < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :block
      t.string :from, null: false
      t.string :to, null: false
      t.string :signature, null: false
      t.decimal :amount, precision: 12, scale: 6, null: false
      t.string :status, null: false, default: "unverified"
    end
  end
end
