require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  setup do
    # テストデータはtest/fixtureのものしか使えない
    @user = users(:akiyoshi)
  end


  test "login with invalid information" do

    # ログイン用のパスを開く
    get login_path
    # 新しいセッションのフォームが正しく表示されたことを確認する
    assert_template "sessions/new"
    # わざと無効なparamsハッシュを使用してセッション用パスにPOSTする
    # たぶんこのsessionは予約変数なんだと思うよ.
    post login_path, session: {email: "", name: ""}
    # 新しいセッションのフォームが再度表示され、フラッシュメッセージが追加されることを確認する
    assert_template "sessions/new"
    assert_not flash.empty?
    # 別のページ (Homeページなど) にいったん移動する
    get root_path
    # 移動先のページでフラッシュメッセージが表示されていないことを確認する
    assert flash.empty?
  end

  #ログインしてもろもろを確認し、ログアウトも確認します
  test "login with valid information followed by logout" do
    #まずログイン用のパスを開く.
    get login_path
    #セッション用パスに有効な情報をPOSTする
    #ここでテストデータを投げる
    post login_path, session: {email: @user.email, password: "password"}
    #リダイレクト先は正しいのか.
    #user_url(@user)の略です
    assert_redirected_to @user
    #実際にページにとびます
    follow_redirect!
    #行くページはshowだね
    assert_template "users/show"
    #ログインリンクが消えていることを確認
    assert_select "a[href=?]", login_path, count: 0
    #同じくログアウトリンクが出現していることを確認
    assert_select "a[href=?]", logout_path
    #プロフィールリンクは出現しているのか.
    #そういやusersはresoucesでルート作ったんだっけ...
    assert_select "a[href=?]", user_path(@user)

    ####こっからログアウト
    #ログアウトのリクエスト発行
    delete logout_path
    #ログアウト確認
    assert_not is_logged_in?
    #ログアウト後はルートに戻る
    assert_redirected_to root_path

    ########
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path

    follow_redirect!
    #あとはリンクの確認
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0

  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

end
