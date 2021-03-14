require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'before_login' do
    describe 'signup_user' do # テストの対象は何か
      context 'valid with all attributes' do # 特定の条件が何か
        # ユーザーの新規作成が成功すること
        it 'success create new user' do # アウトプットが何か
          visit sign_up_path
          fill_in 'Email', with: 'test@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(current_path).to eq login_path
          expect(page).to have_content 'User was successfully created.'
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する'
      end

      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する'
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する'
      end
    end
  end

  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する'
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する'
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する'
      end
      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する'
      end
    end

    describe 'マイページ' do

      context 'タスクを作成' do
        it '新規作成したタスクが表示される'

      end
    end
  end
end
