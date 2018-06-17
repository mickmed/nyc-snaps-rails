class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :picture
      t.text :title
      t.text :description
      t.date :date_taken

      t.timestamps
    end
  end
end
