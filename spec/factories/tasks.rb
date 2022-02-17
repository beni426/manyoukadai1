FactoryBot.define do
  factory :task do
    title { "1/2" }
    content { "funny" }
  end
  factory :second_task do
    title { "1/3" }
    content { "funny3" }
  end
end
