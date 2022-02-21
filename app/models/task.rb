class Task < ApplicationRecord
    validates :title, presence: true
    validates :title, length: { in: 1..40 } 
    validates :content, presence: true
    validates :expired_at, presence: true
    enum status: { todo: 'todo', doing: 'doing', done: 'done' }
   
end
