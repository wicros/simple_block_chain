class CreateTranscationTable < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :block
      t.string :from, null: false
      t.string :to, null: false
      t.string :message, null: true
      t.decimal :amount, precision: 12, scale: 6, null: false
    end
  end
end
