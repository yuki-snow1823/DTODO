class Todo < ApplicationRecord
      belongs_to :user, optional: true
end
