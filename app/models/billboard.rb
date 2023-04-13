class Billboard < ApplicationRecord
  validates :text, length: { maximum: 16, message: "maximo de 16 carateres" }
end
