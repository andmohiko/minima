class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :categories, dependent: :destroy

  def items
    return Item.where(user_id: self.id)
  end

  def categories
    return Category.where(user_id: self.id)
  end
end
