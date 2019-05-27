class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :client, foreign_key: true
      t.text :address
      t.string :contact_phone

      t.timestamps
    end
  end
end
