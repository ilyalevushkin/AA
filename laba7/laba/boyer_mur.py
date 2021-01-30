

def create_dict(pattern):
    d = {}
    len_pattern = len(pattern)
    for i in pattern:
        if (d.get(i) is None):
            d.update({i : len_pattern})

    return d


def get_slide_mas(pattern):
    slide = create_dict(pattern)

    len_pattern = len(pattern)

    for i in range(len(pattern)):
        slide.update({pattern[i] : len_pattern - i - 1})

    slide.update({pattern[len(pattern) - 1] : len_pattern})

    return slide


def get_jump_mas(pattern):

    jump = [0 for i in range(len(pattern))]

    for i in range(len(pattern)):
        jump[i] = 2 * len(pattern) - i - 1

    test = len(pattern) - 1
    target = len(pattern)

    link = [0 for i in range(len(pattern))]

    while (test > -1):
        link[test] = target
        while (target < len(pattern) and (pattern[test] != pattern[target])):
            jump[target] = min(jump[target], len(pattern) - 1 - test)
            target = link[target]
        test -= 1
        target -= 1

    for i in range(target + 1):
        jump[i] = min(jump[i], len(pattern) + target - i)

    temp = link[target]
    while (target < len(pattern) - 1):
        while (target <= temp):
            jump[target] = min(jump[target], temp - target + len(pattern))
            target += 1
        temp = link[temp]

    return jump


def boyer_mur(text, pattern):
    textLoc = len(pattern) - 1
    patternLoc = len(pattern) - 1

    slide = get_slide_mas(pattern)
    jump = get_jump_mas(pattern)

    while (textLoc < len(text) and (patternLoc > -1)):
        if (text[textLoc] == pattern[patternLoc]):
            textLoc -= 1
            patternLoc -= 1
        else:
            if (slide.get(text[textLoc]) is None):
                textLoc += max(len(pattern), jump[patternLoc])
            else:
                textLoc += max(slide.get(text[textLoc]), jump[patternLoc])
            patternLoc = len(pattern) - 1

    if (patternLoc == -1):
        return textLoc + 1
    else:
        return -1