class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true
      t.references :comentable, polymorphic: true, index:true

      t.timestamps
    end
  end
end
