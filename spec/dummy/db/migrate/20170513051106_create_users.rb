class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users, :force => true do |t|
      t.string  :username
      t.string  :email
      t.string  :first_name
      t.string  :last_name

      t.timestamps null: false
    end
  end
end
