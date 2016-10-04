class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.belongs_to :user, foreign_key: true
      t.string :word
      t.string :definition

      t.timestamps
    end
  end
end
