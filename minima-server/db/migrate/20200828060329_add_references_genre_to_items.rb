class AddReferencesGenreToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :genre, foreign_key: true
  end
end
