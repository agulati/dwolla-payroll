class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :amount, :default => 0.0
      t.float :amount_withheld, :default => 0.0
      t.float :net, :default => 0.0
      t.float :payroll_tax_amount, :default => 0.0
      t.string :payment_type, :default => "DWOLLA" # ONly dwolla is supported right now
      t.integer :user_id
      t.boolean :payment_made
      t.date :payment_date
      t.boolean :active
      t.timestamps
    end

    add_index :payments, :user_id
  end
end
