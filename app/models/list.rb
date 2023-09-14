class List < ApplicationRecord
    has_many :items, dependent: :destroy
    validates :title, length:{ in: 3..250}
    
end
