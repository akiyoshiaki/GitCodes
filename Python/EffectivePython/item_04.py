#coding:utf-8

##########
# 4. 複雑な式のかわりにヘルパー関数を書く

from urllib.parse import parse_qs

my_values = parse_qs("red=5&blue=0&green=", keep_blank_values=True)
print(my_values)
#{'red': ['5'], 'blue': ['0'], 'green': ['']}

red = my_values.get("red", [""])[0] or 0
green = my_values.get("green", [""])[0] or 0
opacity = my_values.get("opacity", [""])[0] or 0

print("Red: %r" % red)
print("Green: %r" % green)
print("Opacity: %r" % opacity)

# 同じことが下。明確になる
def get_first_int(values, key, default=0):
    found = values.get(key, [""])
    if found[0]:
        found = int(found[0])
    else:
        found = default
    return found

red = get_first_int(my_values, "red")
green = get_first_int(my_values, "green")
print("Red: %r" % red)
print("Green: %r" % green)
