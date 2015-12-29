# coding: utf-8

class HelloController < ApplicationController
  def index
    render text: 'Hello, World!!'
  end

  def view
    @msg = "ハロー！"
    render "hello/view"
  end

  def list
    #Bookオブジェクト(モデルクラス)のallメソッド呼び出し
    @books = Book.all
  end
end
