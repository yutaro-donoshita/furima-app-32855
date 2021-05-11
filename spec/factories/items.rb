FactoryBot.define do
  factory :item do
    item_text { Faker::Lorem.sentence }
    item_name { Faker::Lorem.sentence }
    category_id { rand(2..11) }
    status_id { rand(2..7) }
    delivery_fee_id { rand(2..3) }
    prefecture_id { rand(2..48) }
    shipment_date_id { rand(2..4) }
    price { rand(300..9_999_999) }
    association :user

    after(:build) do |item|
      item.item_image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
