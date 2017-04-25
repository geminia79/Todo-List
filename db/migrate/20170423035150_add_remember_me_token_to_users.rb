class AddRememberMeTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :remember_me_token, :string
  end
end
