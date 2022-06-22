class Store < ApplicationRecord
    enum status: { empty: 0, warning: 1, normal: 2, attention: 3, full: 4 }

    validates :name, :model, :inventory, presence: true

    def update_status(inventory)
        if inventory == 0
            self.empty!
        elsif inventory < 20
            self.warning!
        elsif inventory > 80
            self.attention!
        elsif inventory == 100
            self.full!
        else
            self.normal!
        end
    end
end
