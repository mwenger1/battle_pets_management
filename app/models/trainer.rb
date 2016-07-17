class Trainer < ApplicationRecord
  has_many :battle_pets, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
