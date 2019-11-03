class Like < ApplicationRecord
    belongs_to :gosssip
	belongs_to :user

        def self.gossips(user_id)
            @likes_gossips = Array.new
            @likes = Like.where(user_id: user_id)
            @likes.each do |like|
                @likes_gossips << like.gosssip_id
            end
            return @likes_gossips
        end

end
