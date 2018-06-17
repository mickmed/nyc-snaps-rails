class Category < ApplicationRecord
    class Photo < ApplicationRecord
        validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
        has_and_belongs_to_many :photos
    end
end
