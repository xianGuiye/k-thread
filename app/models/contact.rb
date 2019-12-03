class Contact < ApplicationRecord
  belongs_to :user

  def search_user
    User.where("user_id = ?", id)
  end
end
