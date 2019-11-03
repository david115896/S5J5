class Gosssip < ApplicationRecord
	validates :title, presence: true, text: true, length: {maximum: 14}
	validates :content, presence: true, text: true
	validates :user_id, presence: true, on: create
		

	belongs_to :user
	has_many :tag_lists
	has_many :tags, through: :tag_lists
	has_many :comments
	has_many :users, through: :comments
	has_many :likes, dependent: :destroy
	has_many :users, through: :likes

end
