FactoryBot.define do
  factory :user do
    name { "user1" }
    email { "user1@example.com" }
    password { "password" }
    password_confirmation {"password"}
    admin { 'true'}
  
  end
  factory :login_user, class: User do
    name { "user2" }
    email { "user2@example.com" }
    password { "password" }
    password_confirmation {"password"}
    admin {'true'}
   
  end
end