FactoryGirl.define do
  factory :post do |f|
    f.title      { Faker::Job.title }
    f.content    { Faker::Lorem.paragraph }
    f.user_id    { create(:user).id }
  end
end
