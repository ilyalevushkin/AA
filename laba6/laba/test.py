class A(object):
    def __init__(self, a, b):
        self.a = a
        self.b = b



def change_first(first):
    first.a = 6
    first.b = 7

first = A(4,5)

change_first(first)

print(first.a, first.b)