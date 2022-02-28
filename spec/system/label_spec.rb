require 'rails_helper'

RSpec.describe 'label管理機能', type: :system do
    let!(:login_user) { FactoryBot.create(:user, name: "ユーザー", email: "login@example.com", password: "password", password_confirmation: "password") }
    # binding.pry
    let!(:task) { FactoryBot.create(:task, title: "test1", content: 'tsrs is test1', expired_at: "2/24", status: "todo",priority: 0 ) }
    let(:label) { create(:label) }
    let(:labelling){create(:labelling)}
    describe '検索機能' do
     before do
       visit new_session_path
       fill_in "Email", with: login_user.email
       fill_in "Password", with: login_user.password
       click_on "Log in"
       click_on 'タスク一覧'
    end
    context 'ラベルをタスクにつけること' do
        it "編集する画面でタスクをつけること" do
          click_on '編集'
          check 'label-1'
          click_button '更新'
          expect(page).to have_text 'タスクを編集しました！'
        end
      end
      context 'タスク詳細画面でラベルを確認すること' do
        it "タスク詳細画面でタスクを表示すること" do
          click_on '詳細確認'
          expect(page).to have_content 'Label'
        end
      end
 
    context 'ラベルの検索できること' do
        it "検索キーワードをラベルに含み、一致するタスク絞り込まれる" do
        
         select 'label-3', from: 'label_id'
         click_button 'search'
          expect(Task.label_search('task')).to include 
        end
      end
    end
end