class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, limit: 100
      t.string :full_name
      t.string :email
      t.bigint :identification_number
      t.text :address
      t.string :contact_phone_1
      t.string :contact_phone_2

      t.timestamps
    end
  end
end
