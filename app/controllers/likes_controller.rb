class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    redirect_to posts_path
  end

  def destroy
    like = current_user.likes.includes(:post).find(params[:id])
    current_user.unlike(like.post)
    redirect_to posts_path, status: :see_other
  end
end
