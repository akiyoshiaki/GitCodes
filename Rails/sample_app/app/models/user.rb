class User < ActiveRecord::Base
  #一意性の保証
  before_save { self.email = email.downcase }
  #存在性の検証, 長さの検証
  validates :name,  presence: true, length: { maximum: 50 }
  #フォーマットの検証, 存在性の検証, 一意性の検証,
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  #セキュアなパスワード実装
  #ただしこれを有効化するにはpassword_digestのカラムを追加する必要がある。
  has_secure_password
  #パスワードの検証
  validates :password, presence: true, length: { minimum: 6 }


end
