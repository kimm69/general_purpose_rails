class UsersController < ApplicationController
  #before_action :admin_user
  skip_before_action :login_required, only: [:new, :create]

rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if current_user.admin?
      edit_user_path
    elsif current_user.id != @user.id
      redirect_to users_url
    end
  end

  def new
    if not current_user
      @user = User.new
    elsif current_user.admin?
      @user = User.new
    elsif current_user
      redirect_to users_url
    end
  end

  def create
    user = User.new(user_params)
    #user.save
    if user.save
      flash[:notice] = "ユーザー作成に成功しました"
      redirect_to users_url
    else
      flash[:alert] = "ユーザー作れてないっス(煽) 確認よろ"
      redirect_to users_url
    #redirect_to users_url
    end

  end

  def update
    if current_user.admin?
      user = User.find(params[:id])
      user.update(user_params)
      redirect_to users_url
    elsif current_user
      user = User.find(params[:id])
      user.update(user_params)
      redirect_to users_url
    end
  end

  def destroy
    if current_user.admin?
      user = User.find(params[:id])
      user.destroy
      redirect_to users_url
    elsif current_user
      user = User.find(params[:id])
      user.destroy
      redirect_to users_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def record_not_found
    redirect_to users_url
  end
end
