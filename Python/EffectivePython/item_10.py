#coding:utf-8

# 10. rangeよりはenumerate

flavor_list = ["vanilla", "chocolate", "pineapple", "strawberry"]
for i, flavor in enumerate(flavor_list):
    print("%d: %s" % (i+1, flavor))

# これと等価
for i, flavor in enumerate(flavor_list, 1):
    print("%d: %s" % (i, flavor))
