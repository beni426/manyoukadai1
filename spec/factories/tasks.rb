FactoryBot.define do
  factory :task do
    title { 'Title 1' }
    content { 'undefined1' }
    expired_at  { '2020/12/01' }
    
  end

  factory :second_task, class: Task do
    title { 'Title 2' }
    content { 'undefined2' }
    expired_at { '2020/12/02' }
    
  end
end
