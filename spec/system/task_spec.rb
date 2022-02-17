require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
    before do
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
    end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        vist new_task_path
        fill_in 'title', with: 'test1'
        fill_in 'content', with: 'this is test1'
        click_button 'save'
        expect(page).to have_content 'Task was successfully created.'
        expect(current_path).to eq '/tasks/1'
       end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task,title:'1/2')
          visit tasks_path
          expect(page).to have_content 'funny'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit task_path(task)
        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content task.title
        expect(page).to have_content task.content
        expect(current_path).to eq task_path(task)
      
       end
     end
  end
end