class Like < ApplicationRecord
  belongs_to :gossip, optional: true
  belongs_to :comment, optional: true

  #validation des attributs
  validate :is_linked
end
