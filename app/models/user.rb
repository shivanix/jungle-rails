class User < ActiveRecord::Base

  has_many :orders 

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

end