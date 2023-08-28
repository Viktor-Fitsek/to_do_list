class Item < ApplicationRecord
  belongs_to :list
  validates :priority, numericality: { greater_than_or_equal_to: 0, less_than: 5 }
  validates :deadline, comparison: { greater_than_or_equal_to: Date.today }
  validates :title, length: { in: 3..250 }
end
