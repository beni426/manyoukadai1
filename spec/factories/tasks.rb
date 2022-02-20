FactoryBot.define do
  factory :task do
    title { '付け加えた名前2' }
    content { '付け加えたコンテント2' }
  end
  factory :second_task,class:Task do
    title { '付け加えた名前2' }
    content { 'Factoryで作ったデフォルトのコンテント２'}
  end
end
