class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :uid, presence: true
  has_many :todos
  has_many :rewards
end
