class City < ApplicationRecord
  has_many :users
  validates_associated :users
  validates :name, presence: true

  #validation des attributs
  validates :zip_code, format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "Ce code postal n'est pas valide." }
end
