class Item < ApplicationRecord
  has_one_attached :photo
  validates :link, format: { with: /https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)/, message: "URL no valido" }

  POSITIONS = ["Nube izquierda", "Nube central", "Nube derecha"]
end
