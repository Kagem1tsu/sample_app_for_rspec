require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    before do
      @user = FactoryBot.create(:user)
    end

    # タイトルがなければ無効な状態であること
    it "is invalid without title" do
      user = FactoryBot.create(:user)
      task = @user.tasks.build(title: nil, status: 0, user_id: 1)
      expect(task).to be_valid
    end

    # ステータスがなければ無効な状態であること
    it "is invalid without status" do
      task = @user.tasks.build(title: 'test', status: nil, user_id: 1)
      expect(task).to be_valid
    end

    # タイトルがユニークである事
    it "is valid with a duplicate title" do
      task1 = @user.tasks.create(title: 'test_task1', status: 0, user_id: 1)
      task2 = @user.tasks.buile(title: 'test_task1', status: 0, user_id: 1)
      expect(task2).to be_invalid
    end
  end
end
