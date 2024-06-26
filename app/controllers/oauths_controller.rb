class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider))
      check_and_update_line_user_id(@user, provider)
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        check_and_update_line_user_id(@user, provider)
        redirect_to root_path, notice: "#{provider.titleize}でログインしました"
      rescue StandardError
        redirect_to root_path, alert: "#{provider.titleize}でのログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  def check_and_update_line_user_id(user, provider)
    return unless provider == 'line'
    authentication = user.authentications.find_by(provider: 'line')
    line_user_id = authentication&.uid

    if line_user_id.present?
      user.update(line_user_id: line_user_id)
    else
      Rails.logger.warn "LINE user_id is not present for user #{user.id}"
    end
  end
end
