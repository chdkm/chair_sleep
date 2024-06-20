class ItemsController < ApplicationController
  before_action :set_post, only: [:create]

  def new
    @item = Item.new
    @post_id = params[:post_id]
    if params[:keyword].present?
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    else
      @items = []
    end
  end


  def select
    @item = RakutenWebService::Ichiba::Item.search(itemCode: params[:item_code]).first
    @post_id = params[:post_id]
    if @item
      render :select
    else
      redirect_to new_item_path, alert: 'アイテムが見つかりませんでした。'
    end
  end

  def create
    @post = current_user.posts.find(params[:post_id])
    @item = @post.items.build(item_params)
    @item.user = current_user
    if @post.items.count >= 5
      redirect_to post_path(@post), alert: '投稿には最大で5個までのアイテムしか登録できません。'
    else
      if @item.save
        redirect_to post_path(@post), notice: 'アイテムを登録しました。'
      else
        render :new
      end
    end
  end

  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy!
    redirect_back fallback_location: root_url, notice: '削除しました。'
  end

  private

  def set_post
    @post = current_user.posts.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to new_item_path, alert: '投稿が見つかりませんでした。'
  end

  def item_params
    params.require(:item).permit(:name, :image_url, :price, :post_id)
  end
end
