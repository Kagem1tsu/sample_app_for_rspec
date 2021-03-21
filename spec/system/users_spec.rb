require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'before_login' do
    describe 'create new user' do
      # テストの対象は何か
      context 'valid with all attributes' do
        # 特定の条件が何か
        # ユーザーの新規作成が成功すること
        it 'success create new user' do
          # アウトプットが何か
          visit sign_up_path
          fill_in 'Email', with: 'test@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(current_path).to eq login_path
          expect(page).to have_content 'User was successfully created.'
        end
      end

      context 'Email is blank' do
        it 'fail to create new user' do
          visit sign_up_path
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          # expect(response.status).to eq(400)
          expect(page).to have_content "Email can't be blank"
        end
      end

      context 'Email already used' do
        it 'fail to create new user' do
          visit sign_up_path
          fill_in 'Email', with: user.email
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content "Email has already been taken"
        end
      end
    end
    # create new user ここまで

    describe 'edit-mypage' do
      context 'not loged-in' do
        it 'fail to access mypage' do
          visit edit_user_path(user)
          expect(current_path).to eq login_path
          expect(page).to have_content "Login requred"
        end
      end
    end
  end
  # before login ここまで


  describe 'after_loged-in' do
    before { login(:user) }
      describe 'edit user' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの編集が成功する' do
            visit edit_user_path(user)
            fill_in 'Email', with: 'test@example.com'
            fill_in 'Password', with: 'test'
            fill_in 'Password_confirmation', wtith: 'test'
            click_button 'Update'
            expect(current_path).to eq user_path(user)
            expect(page).to have_content "User was successfully updated."
          end
        end

        context 'メールアドレスが未入力' do
          it 'ユーザーの編集が失敗する' do
            visit edit_user_path(user)
            fill_in 'Email', with: ''
            fill_in 'Password', with: 'test'
            fill_in 'Password_confirmation', wtith: 'test'
            click_button 'Update'
            expect(current_path).to eq user_path(user)
            expect(page).to have_content "Email can't be blank"
          end
        end

        context '登録済のメールアドレスを使用' do
          it 'ユーザーの編集が失敗する' do
            visit edit_user_path(user)
            fill_in 'Email', with: other_user.email
            fill_in 'Password', with: 'test'
            fill_in 'Password_confirmation', wtith: 'test'
            click_button 'Update'
            expect(current_path).to eq user_path(user)
            expect(page).to have_content "Email has already been taken"
          end
        end
        context '他ユーザーの編集ページにアクセス' do
          it '編集ページへのアクセスが失敗する' do
            visit edit_user_path(other_user)
            expect(current_path).to eq user_path(user)
            expect(page).to have_content "Forbidden access."
          end
        end
      end
      # edit user ここまで

      describe 'マイページ' do

        context 'タスクを作成' do
          it '新規作成したタスクが表示される' do
            visit new_task_path
            fill_in 'Title', with: 'test'
            fill_in 'Contesnt', with: 'test_content'
            click_button 'Create Task'
            expect(current_path).to eq task_path
            expect(page).to have_content "Task was successfully created."
          end
        end
      end
      # my page ここまで
  end
  # after_loged_in ここまで
end