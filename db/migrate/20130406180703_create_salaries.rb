class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.integer :user_id
      t.string :salary_type, :default => "EXEMPT" # ALSO NON-EXEMPT
      t.float :rate, :default => 0.0
      t.string :payment_frequency, :default => "BIWEEKLY" # WEEKLY, BIWEEKLY, MONTHLY
      t.date :effective_from
      t.date :effective_to
      t.boolean :active, :default => true
      t.timestamps
    end

    add_index :salaries, :user_id
  end
end
