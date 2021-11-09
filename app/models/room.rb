class Room < ApplicationRecord
  belongs_to :user
  belongs_to :reserve
  
  mount_uploader :image, ImageUploader
end
