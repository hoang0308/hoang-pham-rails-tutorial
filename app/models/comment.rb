class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :micropost

    validates :user_id, presence: true
    validates :micropost_id, presence: true
    validates :content, presence: true, length: { maximum: Settings.content_maximum}

    def show_sub_comment
        Comment.where("parent_comment_id =?", id)
    end
end
