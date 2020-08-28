class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :genres, dependent: :destroy

  def items
    return Item.where(user_id: self.id)
  end

  def genres
    return Genre.where(user_id: self.id)
  end
end
