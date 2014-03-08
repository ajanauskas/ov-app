FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@test.com" }
    sequence(:login) { |n| "user_#{n}" }

    before(:create) do |user, evaluator|
      user.password = 'labas123'
      user.password_confirmation = 'labas123'
      user.save
    end
  end
end
