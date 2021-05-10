FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(min_length: 6) + Faker::Number.number.to_s }
    password_confirmation { password }
    first_name { Gimei.first.kanji }
    first_name_kana { Gimei.first.katakana }
    last_name { Gimei.last.kanji }
    last_name_kana { Gimei.last.katakana }
    birth_date { Faker::Date.between(from: '1930-01-01', to: '2015-12-31') }
  end
end