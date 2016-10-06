class ChangeReviewBody < ActiveRecord::Migration[5.0]
  def change
    rename_column :reviews, :review, :body
  end
end
