class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, :force => true do |t|
      t.string  :username
      t.string  :email
      t.string  :first_name
      t.string  :last_name
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
