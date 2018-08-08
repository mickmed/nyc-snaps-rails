class Photo < ApplicationRecord
    validates :title, presence: true, uniqueness: true, length: { minimum: 3 }
    is_impressionable :counter_cache => true, :column_name => :impressions_count
    #is_impressionable
    # require 'image_size'
    require 'fastimage'
    #has_many :categories_photos
    #has_many :impressions, foreign_key: "impressionable_id"
    has_and_belongs_to_many :categories
    #mount_uploader :picture, PhotographUploader
    #validate  :picture_size
   
    has_one_attached :image
   
   
   
   
   
    private
    # Validates the size of an uploaded picture.
    #  def picture_size
    #   if picture.size > 15.megabytes
    #    errors.add(:picture, "should be less than 15MB")
    #   end
    #  end
   
end
