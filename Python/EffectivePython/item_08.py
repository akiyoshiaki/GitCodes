#coding:utf-8

# 8. リスト内包表記には、3つ以上の式を避ける

matrix = [[1,2,3], [4,5,6], [7,8,9]]
flat = [x for row in matrix for x in row]
print(flat)

# まだ読みやすい
squared = [[x ** 2 for x in row] for row in matrix]
print(squared)

a = [1,2,3,4,5,6,7,8,9,10]

# 暗示的なand式
b = [x for x in a if x > 4 if x % 2 == 0]
c = [x for x in a if x > 4 and x % 2 == 0]
print(b)
print(c)
