#2度目のマイグレーション。
#データベース上のemailのカラムにインデックス (index)を追加
class AddIndexToUsersEmail < ActiveRecord::Migration
  #データベースのスキーマ変更を担う
  #uniqueオプションで一意性を強制
  #こっちは内容までは自動生成されない。
  def change
    add_index :users, :email, unique: true
  end
end
