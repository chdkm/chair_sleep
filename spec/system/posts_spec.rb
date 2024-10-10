require 'rails_helper'

RSpec.describe '投稿', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe '投稿のCRUD' do
    describe '投稿の一覧' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit '/posts'
          Capybara.assert_current_path("/login", ignore_query: true)
          expect(current_path).to eq('/login'), 'ログインページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        it 'ヘッダーのリンクから投稿一覧へ遷移できること' do
          login_as(user)
          find('#menuBtn').click
          click_on('投稿一覧')
          Capybara.assert_current_path("/posts", ignore_query: true)
          expect(current_path).to eq('/posts'), 'ヘッダーのリンクから投稿一覧画面へ遷移できません'
        end

        it '正しいタイトルが表示されていること' do
          login_as(user)
          find('#menuBtn').click
          click_on('投稿一覧')
          expect(page).to have_title("投稿一覧 | 椅子寝"), '投稿一覧ページのタイトルに「投稿一覧 | 椅子寝」が含まれていません。'
        end

        context '投稿が一件もない場合' do
          it '何もない旨のメッセージが表示されること' do
            login_as(user)
            find('#menuBtn').click
            click_on('投稿一覧')
            expect(page).to have_content('投稿がありません'), '投稿が一件もない場合、「投稿がありません」というメッセージが表示されていません'
          end
        end

        context '投稿がある場合' do
          it '投稿の一覧が表示されること' do
            post
            login_as(user)
            find('#menuBtn').click
            click_on('投稿一覧')
            expect(page).to have_content(post.title), '投稿一覧画面に投稿のタイトルが表示されていません'
            expect(page).to have_content(post.user.name), '投稿一覧画面に投稿者のフルネームが表示されていません'
          end
        end
        context '20件以下の場合' do
          let!(:posts) { create_list(:post, 20) }
          it 'ページングが表示されないこと' do
            login_as(user)
            visit posts_path
            expect(page).not_to have_selector('pagination')
          end
        end

        context '21件以上ある場合' do
          let!(:posts) { create_list(:post, 21) }
          it 'ページングが表示されること' do
            login_as(user)
            visit posts_path
            expect(page).to have_selector('.pagination'), '投稿一覧画面において投稿が21件以上ある場合に、ページネーションのリンクが表示されていません'
          end
        end
      end
    end
    describe '投稿の詳細' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit post_path(post)
          expect(current_path).to eq login_path
          expect(page).to have_content 'ログインしてください'
        end
      end

      context 'ログインしている場合' do
        before do
          post
          login_as(user)
          find('#menuBtn').click
          click_on('投稿一覧')
        end
        it '投稿の詳細が表示されること' do
          click_on('タイトル例')
          Capybara.assert_current_path("/posts/#{post.id}", ignore_query: true)
          expect(current_path).to eq("/posts/#{post.id}"), '投稿のタイトルリンクから投稿詳細画面へ遷移できません'
          expect(page).to have_content post.title
          expect(page).to have_content post.user.name
          expect(page).to have_content post.prepare
          expect(page).to have_content post.content
          expect(page).to have_content post.care
        end
        it '正しいタイトルが表示されていること' do
          click_on('タイトル例')
          expect(page).to have_title("#{post.title} | 椅子寝"), '投稿詳細ページのタイトルに投稿のタイトルが含まれていません。'
        end
      end
    end
    describe '投稿の作成' do
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit '/posts/new'
          Capybara.assert_current_path("/login", ignore_query: true)
          expect(current_path).to eq('/login'), 'ログインしていない場合、投稿作成画面にアクセスした際に、ログインページにリダイレクトされていません'
          expect(page).to have_content('ログインしてください'), 'フラッシュメッセージ「ログインしてください」が表示されていません'
        end
      end

      context 'ログインしている場合' do
        before do
          login_as(user)
          find('#menuBtn').click
          click_on('投稿一覧')
          click_on('新規投稿')
        end

        it '正しいタイトルが表示されていること' do
          expect(page).to have_title("投稿作成 | 椅子寝"), '投稿新規作成ページのタイトルに「投稿作成 | 椅子寝」が含まれていません。'
        end

        it '投稿が作成できること' do
          fill_in 'post_title', with: 'テストタイトル'
          fill_in 'post_prepare', with: 'テスト本文1'
          fill_in 'post_content', with: 'テスト本文2'
          fill_in 'post_care', with: 'テスト本文3'
          file_path = Rails.root.join('spec', 'fixtures', 'example.jpg')
          attach_file "post_image", file_path
          click_button '登録'
          Capybara.assert_current_path("/posts", ignore_query: true)
          expect(current_path).to eq('/posts'), '投稿一覧画面に遷移していません'
          expect(page).to have_content('投稿を作成しました'), 'フラッシュメッセージ「投稿を作成しました」が表示されていません'
          expect(page).to have_content('テストタイトル'), '作成した投稿のタイトルが表示されていません'
        end

        it '投稿の作成に失敗すること' do
          fill_in 'post_title', with: 'テストタイトル'
          file_path = Rails.root.join('spec', 'fixtures', 'example.txt')
          attach_file 'post_image', file_path
          click_button '登録'
          expect(page).to have_content('投稿を作成出来ませんでした'), 'フラッシュメッセージ「投稿を作成出来ませんでした」が表示されていません'
        end
      end
    end

    describe '投稿の更新' do
      before { post }
      context 'ログインしていない場合' do
        it 'ログインページにリダイレクトされること' do
          visit edit_post_path(post)
          expect(current_path).to eq('/login'), 'ログインページにリダイレクトされていません'
          expect(page).to have_content 'ログインしてください'
        end
      end

      context 'ログインしている場合' do
        context '自分の投稿' do
          before do
            login_as(user)
            visit posts_path
            click_on('タイトル例')
            click_on('編集')
          end
          it '投稿が更新できること' do
            fill_in 'post_title', with: '編集後テストタイトル'
            fill_in 'post_prepare', with: '編集後テスト本文1'
            fill_in 'post_content', with: '編集後テスト本文2'
            fill_in 'post_care', with: '編集後テスト本文3'
            click_button '更新'
            Capybara.assert_current_path("/posts/#{post.id}", ignore_query: true)
            expect(current_path).to eq post_path(post)
            expect(page).to have_content('投稿を更新しました'), 'フラッシュメッセージ「投稿を更新しました」が表示されていません'
            expect(page).to have_content('編集後テストタイトル'), '更新後のタイトルが表示されていません'
            expect(page).to have_content('編集後テスト本文1'), '更新後の仮眠を行うまでの準備が表示されていません'
            expect(page).to have_content('編集後テスト本文2'), '更新後の仮眠の寝方が表示されていません'
            expect(page).to have_content('編集後テスト本文3'), '更新後の仮眠後のアクションが表示されていません'
          end

          it '投稿の作成に失敗すること' do
            fill_in 'post_title', with: '編集後テストタイトル'
            fill_in 'post_prepare', with: ''
            click_button '更新'
            expect(page).to have_content('投稿を更新出来ませんでした'), 'フラッシュメッセージ「投稿を更新出来ませんでした」が表示されていません'
          end
        end

        context '他人の投稿' do
          it '編集ボタンが表示されないこと' do
            login_as(another_user)
            visit posts_path
            expect(page).not_to have_selector("#button-edit-#{post.id}"), '他人の投稿に対して編集ボタンが表示されています'
          end
        end
      end
    end

    describe '投稿の削除' do
      before { post }
      context '自分の投稿' do
        it '投稿が削除できること', js: true do
          login_as(user)
          visit '/posts'
          page.accept_confirm { find('a', text: '削除').click }
          expect(current_path).to eq('/posts'), '投稿削除後に、投稿の一覧ページに遷移していません'
          expect(page).to have_content('投稿を削除しました'), 'フラッシュメッセージ「投稿を削除しました」が表示されていません'
        end
      end

      context '他人の投稿' do
        it '削除ボタンが表示されないこと' do
          login_as(another_user)
          visit posts_path
          expect(page).not_to have_selector("#button-delete-#{post.id}"), '他人の投稿に対して削除ボタンが表示されています'
        end
      end
    end
    describe '投稿のブックマーク一覧' do
      before { post }
      context '1件もブックマークしていない場合' do
        it '1件もない旨のメッセージが表示されること' do
          login_as(user)
          visit posts_path
          click_on 'ブックマーク一覧'
          Capybara.assert_current_path("/posts/bookmarks", ignore_query: true)
          expect(current_path).to eq(bookmarks_posts_path), '課題で指定した形式のリンク先に遷移させてください'
          expect(page).to have_content('ブックマークした投稿がありません'), 'ブックマーク中の投稿が一件もない場合、「ブックマーク中の投稿がありません」というメッセージが表示されていません'
        end
      end

      context 'ブックマークしている場合' do
        it 'ブックマークした投稿が表示されること' do
          login_as(another_user)
          visit posts_path
          find("#bookmark-button-for-post-#{post.id}").click
          find('#menuBtn').click
          click_on 'ブックマーク一覧'
          Capybara.assert_current_path("/posts/bookmarks", ignore_query: true)
          expect(current_path).to eq(bookmarks_posts_path), '課題で指定した形式のリンク先に遷移させてください'
          expect(page).to have_content post.title
        end
      end

    end
  end
end

