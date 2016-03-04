require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  setup do
    # テストデータはtest/fixtureのものしか使えない
    @user = users(:akiyoshi)
  end

  #ダメなのをはじけるか
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end

  #実装したい機能を書いてごらんよ
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name  = "Foo Bar"
     email = "foo@bar.com"
     #パスワードは変更しないときは入力したくない
     patch user_path(@user), user: { name:  name,
                                     email: email,
                                     password:              "",
                                     password_confirmation: "" }
     assert_not flash.empty?
     assert_redirected_to @user
     @user.reload
     assert_equal name,  @user.name
     assert_equal email, @user.email

  end


end
