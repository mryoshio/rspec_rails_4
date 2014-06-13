FactoryGirl.define do
  factory :contact do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    after(:build) do |c|
      [:home_phone, :work_phone, :mobile_phone].each do |phone_type|
        c.phones << build(:phone, phone_type: phone_type, contact: c)
      end
    end
  end
end
