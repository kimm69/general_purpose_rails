class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.string :uname
      t.string :task
      t.string :reaction
      t.date :when

      t.timestamps
    end
  end
end
