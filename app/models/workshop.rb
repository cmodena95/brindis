class Workshop < ApplicationRecord
  has_one_attached :photo
  has_rich_text :description
end
