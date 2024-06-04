class UserSettingsController < ApplicationController
  before_action :require_login

  def edit
    if current_user.line_user?
      @user_setting = current_user.user_setting || current_user.build_user_setting
    else
      @user_setting = current_user.user_setting
    end
  end

  def update
    if current_user.line_user?
      @user_setting = current_user.user_setting || current_user.build_user_setting
      if @user_setting.update(user_setting_params)
        redirect_to edit_user_setting_path, notice: '設定が更新されました。'
      else
        render :edit
      end
    else
      redirect_to edit_user_setting_path, alert: 'LINEログインユーザーのみ通知設定が可能です。'
    end
  end

  private

  def user_setting_params
    params.require(:user_setting).permit(:line_notification)
  end
end
