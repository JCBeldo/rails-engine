class Item < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true
end
