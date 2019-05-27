class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 100
      t.string :last_name, limit: 100
      t.string :email
      t.string :password_digest
      t.string :auth_token
      t.references :profile, foreign_key: true

      t.timestamps
    end
    add_index :users, :auth_token, unique: true
  end
end
