FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@test.com" }
    sequence(:login) { |n| "user_#{n}" }

    before(:create) do |user, evaluator|
      passw = evaluator.password || 'labas123'
      user.password = passw
      user.password_confirmation = passw
      user.save
    end
  end
end
