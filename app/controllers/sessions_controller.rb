class SessionsController < ApplicationController
  skip_before_action :login_required


  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to memos_path
    else
      render :new
    end
  end

  def new
  end

  def destroy
    reset_session
    redirect_to login_path
    #このアクションが呼び出されるとセッションをリセットしてログイン画面に戻るという処理
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
    #ストロングパラメータ
  end

end
