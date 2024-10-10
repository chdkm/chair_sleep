require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  it '正しいタイトルが表示されていること' do
    visit '/users/new'
    expect(page).to have_title("ユーザー登録 | 椅子寝"), 'ユーザー登録ページのタイトルに「ユーザー登録 | 椅子寝」が含まれていません。'
  end

  context '新規登録正常' do
    it 'ユーザーが新規作成できること' do
      visit '/users/new'
      expect {
        fill_in 'ユーザー名', with: 'hoge'
        fill_in 'メールアドレス', with: 'example@example.com'
        fill_in 'パスワード', with: '123478'
        fill_in 'パスワード確認', with: '123478'
        click_button '登録'
        Capybara.assert_current_path("/", ignore_query: true)
      }.to change { User.count }.by(1)
      expect(page).to have_content('ユーザー登録が完了しました'), 'フラッシュメッセージ「ユーザー登録が完了しました」が表示されていません'
    end
  end

  context '新規登録エラー' do
    it 'ユーザーが新規作成できない' do
      visit '/users/new'
      expect {
        fill_in 'メールアドレス', with: 'example@example.com'
        click_button '登録'
      }.to change { User.count }.by(0)
      expect(page).to have_content('ユーザー登録に失敗しました'), 'フラッシュメッセージ「ユーザー登録に失敗しました」が表示されていません'
      expect(page).to have_content('ユーザー名を入力してください'), 'フラッシュメッセージ「名を入力してください」が表示されていません'
      expect(page).to have_content('パスワードは3文字以上で入力してください'), 'フラッシュメッセージ「パスワードは3文字以上で入力してください」が表示されていません'
    end
  end
end
