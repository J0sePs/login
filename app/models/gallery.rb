# app/models/gallery.rb
class Gallery < ApplicationRecord
    has_one_attached :media
  
    validates :title, presence: true
    validates :media, presence: true
  end
  