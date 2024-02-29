class MemosController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @memos = Memo.all
  end

  def show
    @memo = Memo.find(params[:id])
  end

  def edit
    @memo = Memo.find(params[:id])
  if current_user.admin?
     edit_memo_path
  elsif current_user.id != @memo.user_id
      redirect_to memos_url

    end
  end

  def new
    @memo = Memo.new
  end

  def create
    memo = current_user.memos.new(memo_params)
    memo.save!
    redirect_to memos_url
  end

  def update
    if current_user.admin?
      memo = Memo.find(params[:id])
      memo.update(memo_params)
      redirect_to memos_url
    elsif current_user
      memo = current_user.memos.find(params[:id])
      memo.update(memo_params)
      redirect_to memos_url
    end
  end

  def destroy
    if current_user.admin?
      memo = Memo.find(params[:id])
      memo.destroy
      redirect_to memos_url
    elsif current_user
      memo = current_user.memos.find(params[:id])
      memo.destroy
      redirect_to memos_url
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:uname, :task, :when, :reaction)
  end

  def record_not_found
    redirect_to memos_path
  end

end
