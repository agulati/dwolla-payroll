class AddStateToUser < ActiveRecord::Migration
  def change
  	add_column :users, :registration_state, :string, :default => "NEW"
  end
end
