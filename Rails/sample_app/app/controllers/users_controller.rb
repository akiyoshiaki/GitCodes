class UsersController < ApplicationController

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


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
