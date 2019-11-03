class Comment < ApplicationRecord
	validates :content, presence:true, text: true
    
    belongs_to :user
    belongs_to :gosssip
end
