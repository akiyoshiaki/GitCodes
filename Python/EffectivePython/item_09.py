#coding:utf-8

# 9 大きな内包表記にはジェネレータ式を考える

value = [len(x) for x in open("item_08.py")]
print(value)

# ジェネレータ式はリスト内包表記を一般化したもの
# 実行時はイテレータを作るのみで、1ステップずつ進められる
ite = (len(x) for x in open("item_08.py"))

#ジェネレータ式の組み合わせ、連鎖ジェネレータ
roots = ((x, x**0.5) for x in ite)
print(next(roots))
