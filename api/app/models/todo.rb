class Todo < ApplicationRecord
      validates :title, presence: true
      validates :title, length: { in: 1..20 }
      validates :point, presence: true
      belongs_to :user, optional: true
end
