class CommentsController < ApplicationController
    before_action :in_micropost, only: [:new, :create,:index]
    before_action :correct_user, only: :destroy

    def new
        @comment = Comment.new(parent_comment_id: params[:comment_id])
    end
    
    def index
        @comments = micropost.show_comment.paginate(page: params[:page])
    end

    def create
        @comment = current_user.comments.build comment_params
        @comment.micropost_id = params[:micropost_id]
        @comment.save
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end

    def destroy
        @micropost = Micropost.find_by(id: @comment.micropost_id)
        @id_temp = @comment.id
        @comment.destroy
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end

    private

        def comment_params
            params.require(:comment).permit(:content,:parent_comment_id)          
        end

        def in_micropost
            @micropost = Micropost.find_by(id: params[:micropost_id])
        end

        def correct_user
            @comment = current_user.comments.find_by(id: params[:id])
            redirect_to root_url if @comment.nil?
        end
end
