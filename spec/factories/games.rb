FactoryBot.define do
  factory :game do
    status { :pending }
    association :owner, factory: :owner
  end
end
