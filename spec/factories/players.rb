FactoryBot.define do
  factory :player, aliases: [:owner] do
    sequence :email do |n|
      "fake#{n}@example.com"
    end
    password { 'Password1' }
  end
end
