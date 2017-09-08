class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(user_path(@user), notice: "ログインしました")
    else
      redirect_to(login_path, alert: "メールアドレスまたはパスワードが不正です")
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: "ログアウトしました")
  end
end
