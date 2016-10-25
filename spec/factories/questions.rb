FactoryGirl.define do
  factory :question do
    sequence(:content) { |n| "#{n}. Sebutkan tanggal kemerdekaan indonesia?" }
    sequence(:answer) { |n| "17 Agustus" }
  end
end
