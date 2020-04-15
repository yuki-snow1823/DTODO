class Reward < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 20 }
  validates :point, presence: true
  belongs_to :user
end
