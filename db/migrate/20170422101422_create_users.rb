class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false
      t.string :password_digest
      t.datetime :reset_password_sent_at
      t.integer :sign_in_count
      t.datetime :current_sign_in_at

      t.timestamps
      t.index :email, unique: true
    end
  end
end
