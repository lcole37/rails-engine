FactoryBot.define do
  factory :invoice_item do
    quantity {Faker::Number.within}
  end
end
