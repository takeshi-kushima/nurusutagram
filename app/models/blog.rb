class Blog < ApplicationRecord
    validates :content, presence: true, length: { in: 1..140 }  
    
    mount_uploader :image, ImageUploader
    
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :users, through: :favorites, source: :user
end
