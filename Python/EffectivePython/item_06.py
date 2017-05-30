#coding:utf-8

# 6. 1つのスライスではstart, end, strideを使わない
# somelist[start:end:stride]

a = ["red", "orange", "yellow", "green", "blue", "purple"]
odds = a[::2]
evens = a[1::2]
print(odds)
print(evens)

# バイト列の逆転(UTF-8には🙅)
x = b"mongoose"
print(x[::-1])

c = ["a", "b", "c", "d", "e", "f", "g", "h"]
print(c[2::2])
print(c[-2::-2])
print(c[-2:2:-2])

# 1つのスライスにstart, end, strideを同時に使わない！
