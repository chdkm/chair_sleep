class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      send_line_notification(@post.user)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :new }
        format.html { render :new }
      end
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(post_id: params[:post_id])
  end


  def send_line_notification(user)
    user_setting = UserSetting.find_by(user_id: user.id)
    if user_setting&.line_notification
      # LINE通知を送信するロジックを呼び出す
      LineNotificationService.send_line_message(user, "新しいコメントが投稿されました: #{@comment.content}")
    else
      Rails.logger.info "LINE notification is disabled for user: #{user.id}"
    end
  end
end