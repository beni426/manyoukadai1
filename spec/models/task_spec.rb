require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is invalid without a title" do
    task = Task.new(title: nil)
    task.valid?
    expect(task.errors[:title]).to include("can't be blank")
  end
  it "is invalid without a content" do
    task = Task.new(content: nil)
    task.valid?
    expect(task.errors[:content]).to include("can't be blank")
  end
end
