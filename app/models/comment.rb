class Comment < ApplicationRecord
  belongs_to :prototype, dependent: :destroy
  belongs_to :user

  validates :text, presence: true
end
