# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :myjoke do
    name "MyString"
    picture_url "MyString"
    audio_url "MyString"
    user_id 1
    approved 1
  end
end
