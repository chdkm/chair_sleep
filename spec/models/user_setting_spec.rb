require 'rails_helper'

RSpec.describe UserSetting, type: :model do
  describe 'バリデーションのテスト' do
    it 'line_notificationがtrueかfalseであること' do
      user_setting = UserSetting.new(line_notification: nil)
      expect(user_setting).not_to be_valid
    end
  end

  describe 'アソシエーションのテスト' do
    it 'userに属していること' do
      assoc = UserSetting.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
