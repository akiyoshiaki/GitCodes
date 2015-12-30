require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  #これで変数を作って記述をまとめられる
  def setup
    @base_title = "サンプルアプリ"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "ヘルプ | #{@base_title}"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "概要 | #{@base_title}"
  end

end
