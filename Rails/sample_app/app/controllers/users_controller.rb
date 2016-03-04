class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    ##とてもべんりなデバッガ
    #debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #ユーザ登録に成功したらログイン
      log_in @user
      #成功した1度目だけに出現するやつ
      #flash変数に代入したメッセージは、リダイレクトした直後のページで表示できるようになる。
      #createアクションの後、つまりusersのshowでflashという変数が使える。
      flash[:success] = "Welcome to the Sample App!!!!!"
      #redirect_to user_url(@user) と等価
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
  end

  def update
    #成功or not
    if @user.update_attributes(user_params)
      #更新に成功したときの処理
      flash[:success] = "profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #beforeフィルタ
    #ログイン済みユーザか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    #あるアクションの前には、
    # 正しいユーザーとしてログインしているのかどうか確認する
    # 実装済みのメソッド使えばわりと簡単
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
