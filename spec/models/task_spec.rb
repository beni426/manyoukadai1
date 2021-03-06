require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:task) { FactoryBot.create(:task, title: 'task',content: 'task to content', expired_at: "2/22",status:'todo') }

  describe '検索機能' do
    # before do
     
    #   visit new_session_path
    #   fill_in "Email", with: login_user.email
    #   fill_in "Password", with: login_user.password
    #   click_on "Log in"
      
    # end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
   
        expect(Task.task_name_search('task')).to include(task)
        expect(Task.task_name_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search('todo')).to include(task)

      end
    end
   context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.task_name_search('task')).to include(task)
        expect(Task.task_name_search('task').status_search('todo')).to include(task)
      end
    end
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
      
        task = Task.new(title: nil , content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: nil )
        expect(task).not_to be_valid
      end
    end
    context 'タスクの終了期限が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗テスト', content: '失敗test',expired_at: nil )
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト',expired_at:'2/12')
        expect(task).not_to be_valid
      end
    end
  end
end
