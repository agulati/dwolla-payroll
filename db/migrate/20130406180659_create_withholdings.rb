class CreateWithholdings < ActiveRecord::Migration
  def change
    create_table :withholdings do |t|

      t.timestamps
    end
  end
end
