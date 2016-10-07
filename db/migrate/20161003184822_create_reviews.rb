class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :word, foreign_key: true, null: false
      t.integer :rating, null: false
      t.text :review, null: false

      t.timestamps
    end
  end
end
