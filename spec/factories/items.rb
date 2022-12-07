FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph}
    unit_price { 2.5 }
    merchant { create(:merchant) }
  end
end
