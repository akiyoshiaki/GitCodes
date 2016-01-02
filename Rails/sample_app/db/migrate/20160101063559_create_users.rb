#最初のマイグレーションファイル。この時はテーブルの準備として用いた。
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
