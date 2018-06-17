class CreateCategoriesPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_photos do |t|
      t.references :photo, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
