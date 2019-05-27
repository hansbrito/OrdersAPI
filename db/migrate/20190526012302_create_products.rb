class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title, limit: 100
      t.text :description
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
#   rails g scaffold product title:string{100} description:text 'price:decimal{10,2}' 
#   rails g scaffold permission title:string{100} description:text
#   rails g scaffold profile title:string{100} description:text
#   rails g scaffold user first_name:string{100} last_name:string{100} email:string password:digest auth_token:token
#   rails g scaffold client name:string{100} full_name:string address:text contact_phone_1:string contact_phone_2:string
#   rails g scaffold order user:references client:references address:text contact_phone:string
#   rails g scaffold comment title:string description:text user:references
#   rails g model permission_profile permission:references profile:references
#   rails g model order_product order:references product:references amount:integer discount:float 'price:decimal{10,2}'
