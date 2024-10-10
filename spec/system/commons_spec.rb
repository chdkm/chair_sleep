require 'rails_helper'

RSpec.describe '共通系', type: :system do
  context 'ログイン前' do
    before do
      visit root_path
    end
    describe 'ヘッダー' do
      it 'ヘッダーが正しく表示されていること' do
        expect(page).to have_content('ログイン'), 'ヘッダーに「ログイン」というテキストが表示されていません'
        expect(page).to have_content('新規登録'), 'ヘッダーに「新規登録」というテキストが表示されていません'
      end
    end

    describe 'フッター' do
      it 'フッターが正しく表示されていること' do
        expect(page).to have_content('利用規約'), '「利用規約」というテキストが表示されていません'
        expect(page).to have_content('プライバリーポリシー'), '「プライバリーポリシー」というテキストが表示されていません'
        expect(page).to have_content('Copyright'), '「Copyright」というテキストが表示されていません'
      end
    end

    describe 'タイトル' do
     it 'タイトルが正しく表示されていること' do
        expect(page).to have_title("椅子寝"), 'トップページのタイトルに「椅子寝」が含まれていません。'
      end
    end
  end

  context 'ログイン後' do
    let(:user) { create(:user) }
    before do
      login_as(user)
      find('#menuBtn').click
    end
    describe 'ヘッダー' do
      it 'ヘッダーが正しく表示されていること', js: true do
        expect(page).to have_content('投稿一覧'), 'ヘッダーに「投稿一覧」というテキストが表示されていません'
        expect(page).to have_content('いいねランキング一覧'), 'ヘッダーに「いいねランキング一覧」というテキストが表示されていません'
        expect(page).to have_content('通知設定'), 'ヘッダーに「通知設定」というテキストが表示されていません'
        expect(page).to have_content('ブックマーク一覧'), 'ヘッダーに「ブックマーク一覧」というテキストが表示されていません'
        expect(page).to have_content('プロフィール設定'), 'ヘッダーに「プロフィール設定」というテキストが表示されていません'
        expect(page).to have_content('ログアウト'), 'ヘッダーに「ログアウト」というテキストが表示されていません'
      end
    end
    describe 'タイトル' do
     it 'タイトルが正しく表示されていること' do
        expect(page).to have_title("椅子寝"), 'トップページのタイトルに「椅子寝」が含まれていません。'
      end
    end
  end
end
