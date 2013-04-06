class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :email
      t.string :username
      t.string :password_hash
      t.string :salt
      t.string :auth_key
      t.string :ssn
      t.string :dwolla_id
      t.boolean :active
      t.boolean :is_manager
      t.datetime :last_login
      t.timestamps
    end

    add_index :users, :email
    add_index :users, :username
  end
end
