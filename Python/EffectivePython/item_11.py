#coding:utf-8

# 11. イテレータの並列処理にはzip

names = ["taro", "jiro", "zaemon", "tarojirozaemon"]
letters = [len(x) for x in names]
print(names, letters)

max_letters = 0
longest_name = ""
for name, count in zip(names, letters):
    if count > max_letters:
        longest_name = name
        max_letters = count
print("Longest -> %s: %d" % (longest_name, max_letters))

#同じ長さじゃないリストを扱う際は注意…
