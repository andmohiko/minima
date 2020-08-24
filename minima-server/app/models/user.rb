class User < ApplicationRecord
  has_many :items, dependent: :destroy
  def items
    return Item.where(user_id: self.id)
  end
end
