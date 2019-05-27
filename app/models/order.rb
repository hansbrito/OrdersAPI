class Order < ApplicationRecord
  belongs_to :user
  belongs_to :client

  # Autoriza ao modelo a aceitar informações de outro módulo em um mesmo formulário
  # accepts_nested_attributes_for :order_products, reject_if: :all_blank, allow_destroy: true
end
