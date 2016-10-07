class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.string :word, null: false
      t.string :definition, null: false

      t.timestamps
    end
  end
end
