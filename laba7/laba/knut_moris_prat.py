

def get_fail(substring):
    fail = [0 for i in range(len(substring))]
    fail[0] = -1
    for i in range(1, len(substring)):
        temp = fail[i - 1]
        while ((substring[temp] != substring[i - 1]) and (temp > -1)):
            temp = fail[temp]
        fail[i] = temp + 1
    return fail

def knut_moris_prat(text, substring):
    subLoc = 0
    textLoc = 0

    fail = get_fail(substring)

    while (textLoc < len(text) and subLoc < len(substring)):
        if (subLoc == -1 or text[textLoc] == substring[subLoc]):
            textLoc += 1
            subLoc += 1
        else:
            subLoc = fail[subLoc]

    if (subLoc > len(substring) - 1):
        return textLoc - len(substring)
    else:
        return -1