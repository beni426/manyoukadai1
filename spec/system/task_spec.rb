require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

   let!(:login_user) { FactoryBot.create(:user, name: "ユーザー", email: "login@example.com", password: "password", password_confirmation: "password") }
   let!(:task) { FactoryBot.create(:task, title: "test1", content: 'tsrs is test1', expired_at: "2/24", status: "todo",priority: 0) }
  describe '検索機能' do
    before do
      visit new_session_path
      fill_in "Email", with: login_user.email
      fill_in "Password", with: login_user.password
      click_on "Log in"
      click_on 'タスク一覧'

    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'test'
        click_button 'search'
        expect(page).to have_content 'test1'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select 'todo',from: :status 
        expect(Task.status_search('todo')).to include(Task.first)
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'title', with: "付け加えた名前1"
        select 'todo',from: :status
        click_button 'search'
        expect(Task.task_name_search('task').status_search('todo')).to include
      end
    end
  end
  describe '新規作成機能' do
    before do
      visit new_session_path
      fill_in "Email", with: login_user.email
      fill_in "Password", with: login_user.password
      click_on "Log in"
      click_on "タスク一覧"
    end

    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        click_button 'タスクを作成'
        fill_in 'タイトル', with: 'test1'
        fill_in '詳細', with: 'tsrs is test1'
        fill_in '終了期限', with: '2/12'
       select 'todo',from: :ステータス
        click_button '登録'
        expect(page).to have_content 'タスクを作成しました!'
        expect(current_path).to eq '/tasks'
       end
    end
  
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'test1'
      end
     end
     context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do

        task_test = all('td').first
        expect(task_test).to have_content "test1"
        save_and_open_page
     end
    end
     context "終了期限でソートするテスト場合" do
      it "終了期限が最も未来のタスクが一番上に表示される" do

        click_on '終了期限'
        task_test = all('td').first
        expect(task_test).to have_content "test1"
        save_and_open_page
      end
    end
    context "優先順位でソートするテスト場合" do
      it "優先順位が最も高いのタスクが一番上に表示される" do
        click_on '優先順位'
        task_test = all('td').first
        expect(task_test).to have_content "test1"
        save_and_open_page
      end
    end
   context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
       
        click_on '詳細確認'
        expect(page).to have_content task.title
        expect(page).to have_content task.content
        expect(current_path).to eq task_path(task)
      
       end
     end
  end
end