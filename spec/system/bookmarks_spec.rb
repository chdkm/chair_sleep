require 'rails_helper'

RSpec.describe 'ブックマーク', type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:bookmark) { create(:bookmark, user: user) }

  it 'ブックマークができること' do
    login_as(user)
    visit '/posts'
    find("#bookmark-button-for-post-#{post.id}").click
    expect(current_path).to eq('/posts'), 'ブックマーク作成後に、掲示板一覧画面が表示されていません'
    expect(page).to have_css("#unbookmark-button-for-post-#{post.id}"), "idがunbookmark-button-for-post-#{post.id}のリンクが表示されていません"
  end

  it 'ブックマークを外せること' do
    login_as(user)
    visit '/posts'
    find("#unbookmark-button-for-post-#{bookmark.post.id}").click
    expect(current_path).to eq('/posts'), 'ブックマーク解除後に、掲示板一覧画面が表示されていません'
    expect(page).to have_css("#bookmark-button-for-post-#{post.id}"), "idがbookmark-button-for-post-#{post.id}のリンクが表示されていません"
  end
end
