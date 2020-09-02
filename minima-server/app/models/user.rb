class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :categories, dependent: :destroy

  def items
    Item.where(user_id: id)
  end

  def categories
    Category.where(user_id: id)
  end
end
