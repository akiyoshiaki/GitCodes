#coding:utf-8

# 5. シーケンスをどのようにスライスするか知っておく
# somelist[start:end] startは含まれ、endは含まれない

a = ["a", "b", "c", "d", "e", "f", "g", "h"]

b = []
for i in range(50):
    b.append(i)

print("first ten : %r" % b[:10])
print("last ten : %r" % b[-10:])

# コピー
b = a[:]
print("a & b : %r" % (a == b))
