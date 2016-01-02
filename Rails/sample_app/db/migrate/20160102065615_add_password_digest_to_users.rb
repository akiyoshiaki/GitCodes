#3度目のマイグレーションファイル。
#これはpassword_digestを追加するためのアレ。
class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
  end
end
