class Topic < ApplicationRecord
  has_many :microposts, dependent: :destroy
end
