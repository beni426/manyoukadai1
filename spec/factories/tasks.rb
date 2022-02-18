FactoryBot.define do
  factory :task do
    title { '付け加えた名前1' }
    content { '付け加えたコンテント1' }
  end
  factory :second_task,class:Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２'}
  end
end
