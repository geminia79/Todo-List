class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid, null: false

      t.timestamps
      t.index :uid, unique: true
    end
  end
end
