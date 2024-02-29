class AddUserIdToMemos < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM memos;'
    #booksテーブルの全データ削除
    add_reference :memos, :user, null: false, index: true
  end

  def down
    remove_reference :memos, :user, index: true
    #booksテーブルとusersテーブルの関連付けを削除する
  end
end
