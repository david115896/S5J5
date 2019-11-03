class Tag < ApplicationRecord
	validates :title, presence: true
	#, format: { with: /\A$#[\w\_]{2,20}\z/, message: "format #hashtag entre 2 et 10 caracteres" }

	has_many :tag_lists
	has_many :gosssips, through: :tag_lists
end
