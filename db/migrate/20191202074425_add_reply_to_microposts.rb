class AddReplyToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :reply, :integer
  end
end
