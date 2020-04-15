class User < ApplicationRecord
  validates :name, presence: true
  has_many :todos
  has_many :rewards
end
