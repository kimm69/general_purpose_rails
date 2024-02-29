class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :redirect_to
  #helper_method :admin_user
  before_action :login_required

  private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_required
      redirect_to login_url unless current_user
      #current_userがfalseであるとき（誰もログインしていないとき）ログイン画面にリダイレクトする
    end

    def admin_user
      current_user.admin?
    end



end
