class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :word, foreign_key: true
      t.integer :rating
      t.text :review

      t.timestamps
    end
  end
end
