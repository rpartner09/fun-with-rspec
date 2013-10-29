# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	first_name "Fred"
  	last_name "Stevens"
  	email "fred@gmail.com"
  end

  factory :user_with_link, parent: :user do
  	after(:create) do |user|
  	  FactoryGirl.create(:link, user:user)
  	end
  end
end
