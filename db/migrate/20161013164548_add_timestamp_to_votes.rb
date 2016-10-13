class AddTimestampToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column(:votes, :created_at, :datetime)
    add_column(:votes, :updated_at, :datetime)
  end
end
