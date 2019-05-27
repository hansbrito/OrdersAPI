# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#   Lista de Permissões para fazer o SEED, não são todas as possíveis, são só uns exemplos
#   Validação de permissões que utiliza REGEXP para validar se a URL está nas permissões do usuário
_permission_list = ['[A-Z]_api_v1_', 'GET_api_v1_permissions_\d$', 'GET_api_v1_profiles$', 'GET_api_v1_permissions$', 'GET_api_v1_users$']

5.times do |index|
    @permission = Permission.create({
        title: _permission_list[index],
        description: Faker::Lorem.sentence
    })

    @profile = Profile.create({
        title: Faker::Lorem.word,
        description: Faker::Lorem.sentence,
        permission_ids: [@permission.id]
    })

    @user = User.create({
        first_name: Faker::Name.name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password_digest: BCrypt::Password.create('123456').to_s,
        auth_token: Faker::Lorem.characters(20),
        profile_id: @profile.id
    })

    @product = Product.create({
        title: Faker::App.name,
        description: Faker::Lorem.paragraph_by_chars(256, false),
        price: Faker::Number.decimal(2, 2)
    })

    @client = Client.create({
        name: Faker::Company.name,
        full_name: Faker::Company.name,
        email: Faker::Internet.email,
        identification_number: Faker::Company.brazilian_company_number,
        address: Faker::Address.full_address,
        contact_phone_1: Faker::PhoneNumber.phone_number_with_country_code,
        contact_phone_2: Faker::PhoneNumber.cell_phone_with_country_code
    })

    @order = Order.create({
        user_id: @user.id,
        client_id: @client.id,
        address: Faker::Address.full_address,
        contact_phone: Faker::PhoneNumber.cell_phone_with_country_code
    })

    @discount = Faker::Number.decimal(0, 3)

    @order_product = OrderProduct.create({
        order_id: @order.id,
        product_id: @product.id,
        amount: Faker::Number.between(1, 1000),
        discount: @discount,
        price: (@product.price * (1.0 - @discount.to_f))
    })

end