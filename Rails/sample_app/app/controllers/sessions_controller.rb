class SessionsController < ApplicationController
  def new
  end

  def create
    #フォームから受け取り,emailで検索
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #ユーザログイン後にユーザページにリダイレクトする
      log_in user
      #remember_meするか否かでログインを永続化するか決める
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      #ログイン失敗
      #エラーメッセージ出してからやり直させる
      flash.now[:danger] = 'Invalid email/password combination'
      render "new"
    end
  end

  #現在のユーザをログアウト.セッション実装はヘルパーで.
  def destroy
    log_out if logged_in? #後置if
    redirect_to root_url
  end
end
