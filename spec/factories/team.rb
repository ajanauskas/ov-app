FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "test-team #{n}" }
    owner { FactoryGirl.create(:user) }
  end
end
