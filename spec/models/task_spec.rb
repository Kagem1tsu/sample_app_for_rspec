require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    # すべての属性が設定されていれば有効な状態であること
    # その場合エラーが存在しないこと
    it 'is valid with all attributes' do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    # タイトルがなければ無効な状態であること
    it "is invalid without title" do
      task_without_title = build(:title, title: "")
      expect(task_without_title).to be_invalid
      expect(task_without_title.errors[:title]).to eq ["can't be blank"]
    end

    # ステータスがなければ無効な状態であること
    it "is invalid without status" do
      task_without_status = build(:task, status: nil)
      expect(task_without_status).to be_invalid
      expect(task_without_status.errors[:status]).to eq ["can't be blank"]
    end

    # タイトルが同一の場合は無効な状態であること
    it "is valid with a duplicate title" do
      task = create(:task)
      task_with_duplicated_title = build(:task, title: task.title)
      expect(task_with_duplicated_title).to be_invalid
      expect(task_with_duplicated_title.errors[:title]).to eq ["has already been taken"]
    end

    # タイトルが異なる場合は有効な状態であること
    it 'is valid with another title' do
      task = create(:task)
      task_with_another_title = build(:task, title: 'another_title')
      expect(task_with_another_title).to be_valid
      expect(task_with_another_title.errors).to be_empty
    end
  end
end
