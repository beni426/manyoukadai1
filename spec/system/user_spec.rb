require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user, name: "ユーザー", email: "login@example.com", password: "password", password_confirmation: "password",admin:'true') }
    describe 'ユーザー新規作成' do
        context 'ユーザーを新規作成した場合' do
          it '作成したユーザーが表示される' do
            visit new_user_path
            expect(new_user_path).to eq new_user_path
            fill_in '名前',with: 'user'
            fill_in 'メールアドレス',with: 'user001@example.com'
            fill_in 'パスワード',with: '000000​'
            fill_in '確認用パスワード',with: '000000​'
            click_on 'Create'
            expect(page).to have_content 'user'
          
          end
          it '​ログインしていない時はログイン画面に飛ぶテスト​' do
            visit tasks_path
            expect(current_path).to eq new_session_path
          end
        end
        context 'セッション機能のテスト' do
          it  'ログインができること' do
            visit new_session_path
            fill_in 'Email',with: "login@example.com"
            fill_in 'Password',with: 'password'
            click_on 'Log in'
            expect(page).to have_text 'ログインしました'
          end
          it '自分の詳細画面(マイページ)に飛べること' do
            visit new_session_path
            fill_in 'Email',with: "login@example.com"
            fill_in 'Password',with: 'password'
            click_on 'Log in'
            expect(page).to have_content 'メールアドレス'
          end

          it 'ログアウトができること'do
          visit new_session_path
          fill_in 'Email',with: "login@example.com"
          fill_in 'Password',with: 'password'
          click_on 'Log in'
          click_on 'Logout'
          expect(current_path).to eq new_session_path

          end
        end
     end
      describe '管理画面のテスト' do
          context '管理ユーザは管理画面にアクセスできること' do
            it '作成したユーザーが表示される' do
              visit admin_users_path
              expect(admin_users_path).to eq admin_users_path
              expect(page).to have_content 'Sign up'
             end
          end
          context '一般ユーザは管理画面にアクセスできるない' do
            let!(:user) { FactoryBot.create(:user, name: "ユーザー1", email: "login1@example.com", password: "password", password_confirmation: "password",admin:'false') }
            it '一般ユーザーが管理画面にアクセスできない' do
             visit admin_users_path
              expect(tasks_path).to eq tasks_path
             end
          end
          context '管理ユーザは管理画面にアクセスできること' do
            it '管理ユーザはユーザの新規登録ができること' do
              visit new_session_path
              fill_in 'Email', with: "login@example.com"
              fill_in 'Password', with:"password"
              click_on 'Log in'
              click_on  '管理者画面'
              click_on  'ユーザー作成'
              fill_in '名前',with: 'user'
              fill_in 'メールアドレス',with: 'user001@user.com'
              fill_in 'パスワード',with: '000000​'
              fill_in '確認用パスワード',with: '000000​'
              click_on 'Create'
              expect(page).to have_content 'user'
              
            end
          end
      end
      context '管理ユーザは管理画面にアクセスできること' do
         let!(:user) { FactoryBot.create(:user, name: "ユーザー", email: "login@example.com", password: "password", password_confirmation: "password",admin:'true') }
            it '管理ユーザはユーザの詳細画面にアクセスできること' do
              visit new_session_path
              fill_in 'Email', with: "login@example.com"
              fill_in 'Password', with:"password"
              click_on 'Log in'
              click_on  '管理者画面'
              click_on 'ユーザー詳細'
              expect(page).to have_content 'ユーザーの詳細ページです'
              
            end
          end
          context '管理ユーザは管理画面にアクセスできること' do
           it '管理ユーザはユーザの編集画面からユーザを編集できること' do
            visit new_session_path
            fill_in 'Email', with: "login@example.com"
            fill_in 'Password', with:"password"
            click_on 'Log in'
            click_on  '管理者画面'
            click_on 'ユーザー編集'
            expect(edit_admin_user_path(user.id)).to eq edit_admin_user_path(user.id)
            expect(page).to have_content '登録しているユーザーを編集する'
            end  
           end
           context '管理ユーザは管理画面にアクセスできること' do
            it '管理ユーザはユーザの削除をできること' do
              visit new_session_path
              fill_in 'Email', with: "login@example.com"
              fill_in 'Password', with:"password"
              click_on 'Log in'
              click_on  '管理者画面'
              click_on '削除'
              expect(page.driver.browser.switch_to.alert.text).to eq  '本当に削除していいですか？' 
              end
            end
       
    end