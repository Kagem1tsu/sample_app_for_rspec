FactoryBot.define do
  factory :task do
    sequnce(:title, 'title_1')
    content { 'content' }
    status { :todo }
    deadline { 1.week.from_now }
    association: user
  end
end
