class Event < ApplicationRecord
  has_one_attached :poster
  has_many_attached :photos
  has_rich_text :description
end
