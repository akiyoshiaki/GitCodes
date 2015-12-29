class Task < ActiveRecord::Base
  belongs_to :project
  validates :title, presence: true
  #終わってないものだけを検索するように
  #書き方よくわからん、、、
  scope :unfinished, -> {where(done: false)}
end
