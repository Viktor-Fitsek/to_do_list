class List < ApplicationRecord
    has_many :items
    validates :title, length:{ in: 3..250}
end
