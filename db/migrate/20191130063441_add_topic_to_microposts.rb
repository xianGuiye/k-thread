class AddTopicToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_reference :microposts, :topic, foreign_key: true
  end

end
