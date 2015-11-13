class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id, null: false
      t.integer :contact_id, null: false

      t.timestamps null: false
    end
  end
end
