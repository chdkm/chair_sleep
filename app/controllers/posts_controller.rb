class PostsController < ApplicationController
  def index
    posts = if (item_tag_name = params[:item_tag_name])
              Post.with_tag(item_tag_name)
            else
              Post.all
            end
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save_with_tags(item_tag_names: params.dig(:post, :item_tag_names).split(',').uniq)
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.save_with_tags(item_tag_names: params.dig(:post, :item_tag_names).split(',').uniq)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, status: :see_other
  end

  def bookmarks
    @bookmark_posts = current_user.bookmarks_posts.includes(:user).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :image_cache)
  end
end