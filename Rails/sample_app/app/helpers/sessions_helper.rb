module SessionsHelper

  #渡されたユーザでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  #セッション永続化の手続き
  def remember(user)
    #まずはモデルで定義したrememberメソッドを使う
    #????
    user.remember
    #わかりません
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #現在のユーザをログアウト
  def log_out()
    session.delete(:user_id)
    @current_user = nil
  end

  #現在ログインしているユーザを返す
  #もちろんログイン時に限る
  #記憶トークンcookieに対応するユーザを返す
  def current_user
    # 比較ではない。
    # sessionにuser_idが存在すれば一時セッションからユーザを取り出す
    if (user_id = session[:user_id])
      #find_byとかはDBからの検索ですよ
      @current_user ||= User.find_by(id: session[:user_id])

    # それ以外は、cookiesからユーザを取り出して対応する永続セッションにログイン？？？
    elsif (user_id = cookies.signed[:user_id])
      #raise       # テストがパスすれば、この部分がテストされていないことがわかる
      user = User.find_by(id: user_id)
      # さっぱりわかりません
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  # はてなつけるのもアリらしいっすよ…
  def logged_in?
    !current_user.nil?
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーがログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end


end
