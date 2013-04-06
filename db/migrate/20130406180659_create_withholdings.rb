class CreateWithholdings < ActiveRecord::Migration
  def change
    create_table :withholdings do |t|
      t.integer :user_id
      t.integer :allowances_claimed, :default => 0
      t.float :additional_withholding_amount, :default => 0.0
      t.boolean :is_exempt, :default => false
      t.boolean :is_married, :default => false
      t.string :formula_file, :default => "us/ny/nyc_exempt.rb"
      t.boolean :active, :default => 0 # When use is initially created they are not active
      t.date :effective_from
      t.date :effective_to
      t.timestamps
    end

    add_index :withholdings, :user_id
  end
end
