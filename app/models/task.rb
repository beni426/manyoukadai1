class Task < ApplicationRecord
    validates :title, presence: true
    validates :title, length: { in: 1..40 } 
    validates :content, presence: true
    validates :expired_at, presence: true
    belongs_to  :user
    enum status: { todo: "todo", doing: "doing",done: "done" }
    enum priority: {low: 0, medium: 1, high: 2 }
    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings
    scope :task_name_search, -> (query) {where("title LIKE ?", "%#{query}%")}
	  def task_name_search(query)
	  where("title LIKE ?", "%#{query}%")
	  end

   scope :status_search, -> (query) {where(status: query)}
   def status_search(query)
    where(status: query)
   end
   scope :label_search, -> (query) {where(label: query)}
   def label_search(query)
    where(label: query)
   end
end
