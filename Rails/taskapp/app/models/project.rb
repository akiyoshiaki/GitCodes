class Project < ActiveRecord::Base
  has_many :tasks
  #validationを設定するよ。
  validates :title,
  presence: {message: "入力してください(>_<)"},
  length: {minimum: 2, message: "みじかすぎです."}
end
