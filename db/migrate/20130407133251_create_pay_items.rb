class CreatePayItems < ActiveRecord::Migration
  def change
    create_table :pay_items do |t|
      t.integer :user_id
      t.string :payment_type, :default => "HOURLY" # Can also be "SALARY"
      t.float :unit_amount
      t.float :quantity
      t.float :total
      t.boolean :active, :default => true
      t.date :effective_date
      t.timestamps
    end

    add_index :pay_items, :user_id
  end
end
