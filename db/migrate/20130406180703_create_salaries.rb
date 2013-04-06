class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|

      t.timestamps
    end
  end
end
