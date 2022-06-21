class Store < ApplicationRecord
    validates :name, :model, :inventory, presence: true
end
