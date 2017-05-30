#coding:utf-8

# 7. mapやfilterの代わりにリスト内包表記を使う

a = [1,2,3,4,5,6,7,8,9,10]
squares = [x ** 2 for x in a]
print(squares)

even_squares = [x**2 for x in a if x % 2 == 0]
print(even_squares)


# 辞書と集合にも適応可能
taros = {"taro": 1, "jiro": 2, "saburo": 3}
rank_dict = {rank: name for name, rank in taros.items()}
taros_len_set = {len(name) for name in rank_dict.values()}
print(rank_dict)
print(taros_len_set)
