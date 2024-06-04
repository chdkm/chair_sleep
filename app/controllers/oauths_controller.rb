class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider))
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
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

  def create_user_from_provider(provider)
    user = create_from(provider)
    line_user_id = user.authentications.find_by(provider: 'line')&.uid
    if user.persisted? && line_user_id.present?
      user.update(line_login: true)
      user.create_user_setting(line_user_id: line_user_id)
    end
    user
  end
end
