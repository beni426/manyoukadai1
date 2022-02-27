class User < ApplicationRecord
  before_destroy :admin_destroy
  before_update :admin_update
  validates :name, presence: true, length: {maximum: 20}, uniqueness: true
  validates :email, presence: true, length: {maximum: 255},
      format: {with: /\A[\w.!#$%&'*+\/=?^`{|}~-]+@[\w.-]+\.[\w-]+\z/i},
      uniqueness: true
  before_validation {email.downcase!}
  has_secure_password
  validates :password, length: {minimum: 6}, allow_nil: true
  has_many :tasks,dependent: :destroy
  validates :admin, inclusion: [true,false,'true','false']
  attribute :admin, default: false

  private
    def admin_destroy
      throw(:abort) if self.admin? && User.where(admin: true).count == 1
    end
    def admin_update
    
      throw(:abort) if User.where(admin: true).count == 1 && self.admin == 'false' && !( self.admin == @user)
    end 
end  
