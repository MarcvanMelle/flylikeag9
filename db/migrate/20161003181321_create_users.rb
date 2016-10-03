class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.integer :favorite_word_id
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
