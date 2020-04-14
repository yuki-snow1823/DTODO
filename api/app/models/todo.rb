class Todo < ApplicationRecord
      validates :title, presence: true
      validates :title, length: { maximum: 20 }
      validates :point, presence: true
      belongs_to :user, optional: true
end
