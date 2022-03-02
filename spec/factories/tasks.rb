FactoryBot.define do


 
  factory :task do
    # title { 'Title 1' }
    # content { 'undefined1' }
    # expired_at  { '2020/12/01' }
    # status { 'todo' }
    # labels { 'decorated'}
    after(:create) do |task|
      create_list(:labelling, 1, task: task, label: create(:label))
    end
    association :user, factory: :user
   
  end

  # factory :second_task, class: Task do
  #   title { 'Title 2' }
  #   content { 'undefined2' }
  #   expired_at { '2020/12/02' }
  #   status { 'done' }
  #   labels { 'decorated'}
  #   association :user, factory: :user
   
  # end
end
