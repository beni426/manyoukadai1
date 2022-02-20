require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
        FactoryBot.create(:task,title: '付け加えた名前1',content:'付け加えたコンテント1')
        FactoryBot.create(:second_task,title:'付け加えた名前2',content:'付け加えたコンテント2')
    end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'タイトル', with: 'test1'
        fill_in '詳細', with: 'tsrs is test1'
        fill_in '終了期限', with: '2/12'
        click_button '登録'
        expect(page).to have_content 'タスクを作成しました!'
        expect(current_path).to eq '/tasks'
       end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task,title:'付け加えた名前1')
         visit tasks_path
          expect(page).to have_content '付け加えたコンテント1'
      end
     end
     context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_test = all('td').first
        expect(task_test).to have_content "付け加えた名前2"
        save_and_open_page
     end
    end
     context "終了期限でソートするテスト場合" do
      it "終了期限が最も未来のタスクが一番上に表示される" do
        visit tasks_path
        click_on '終了期限でソートする'
        task_test = all('td').first
        expect(task_test).to have_content "付け加えた名前2"
        save_and_open_page
      end
    end
  end
  describe '詳細表示機能' do
    let!(:task_1){FactoryBot.create(:task, title:'タスク1',content: 'タスク１のcontent')}
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit task_path(task_1)
        expect(page).to have_content 'タスク詳細画面'
        expect(page).to have_content task_1.title
        expect(page).to have_content task_1.content
        expect(current_path).to eq task_path(task_1)
      
       end
     end
  end
end