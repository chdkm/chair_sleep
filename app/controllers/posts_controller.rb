class PostsController < ApplicationController
  def index
    posts = if (item_tag_name = params[:item_tag_name])
              Post.with_tag(item_tag_name)
            else
              Post.all
            end
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user, :item_tags).order(created_at: :desc).page(params[:page])
  end

  def search_tag
    @item_tags = ItemTag.where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end

  def show
    @post = Post.find(params[:id])
    @items = @post.items
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save_with_tags(item_tag_names: params.dig(:post, :item_tag_names).split(',').uniq)
      redirect_to posts_path, success: t('defaults.flash_message.created', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save_with_tags(item_tag_names: params.dig(:post, :item_tag_names).split(',').uniq)
      redirect_to post_path(@post), success: t('defaults.flash_message.updated', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, success: t('defaults.flash_message.deleted', item: Post.model_name.human), status: :see_other
  end

  def bookmarks
    @q = current_user.bookmarks_posts.ransack(params[:q])
    @bookmark_posts = @q.result(distinct: true).includes(:user, :item_tags).order(created_at: :desc).page(params[:page])
  end

  def likes
    @like_posts = Post.includes(:user, :item_tags).order(likes_count: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:title, :prepare, :content, :care, :image, :image_cache)
  end
end