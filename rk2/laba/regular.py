import re

def regular(line):
    result = re.findall(r'(?:ИУ|ИБМ|Э)[1-9]-[1-8][1-9][А-Я]', line)
    return result