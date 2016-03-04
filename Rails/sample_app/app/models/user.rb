class User < ActiveRecord::Base

  #ログインの永続化のため
  attr_accessor :remember_token

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
  #パスワード検証
  #パスワードが空でもプロフ更新できるように
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


  #########クラスメソッド
  # よくわからんが、モデルに実装する。

  # 与えられた文字列のハッシュ値を返す
  # 元はといえばfixture用のメソッド
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)

  end

  #ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end


  # 永続的セッションで使用するユーザーをデータベースに記憶する
  def remember
    # remember_tokenを使ってremember_digestを作る
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    #このダイジェストはどっからきとるんじゃ...
    #ダイジェストがない場合にも対応
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーログインを破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

end
