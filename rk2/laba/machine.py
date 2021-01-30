

def machine(line):
    result = {}
    faculty = ''
    state = 0
    state_3_choice = [1,2,3,4,5,6,7,8,9]
    state_5_choice = [1,2,3,4,5,6,7,8]
    state_6_choice = [1,2,3,4,5,6,7,8,9]
    state_7_choice = ['А','Б','В','Г','Д','Е',
                      'Ж','З','И','Й','К','Л',
                      'М','Н','О','П','Р','С',
                      'Т','У','Ф','Х','Ц','Ч',
                      'Ш','Щ','Ъ','Ы','Ь','Э',
                      'Ю','Я']
    i = 0
    while (i < len(line)):
        if (state == 0):
            if (line[i] == 'И'):
                state = 1
                faculty += line[i]
                i += 1
            elif (line[i] == 'Э'):
                state = 3
                faculty += line[i]
                i += 1
            else:
                i += 1
        elif (state == 1):
            if (line[i] == 'Б'):
                state = 2
                faculty += line[i]
                i += 1
            elif (line[i] == 'У'):
                state = 3
                faculty += line[i]
                i += 1
            else:
                faculty = ''
                state = 0
        elif (state == 2):
            if (line[i] == 'М'):
                state = 3
                faculty += line[i]
                i += 1
            else:
                faculty = ''
                state = 0
        elif (state == 3):
            try:
                num = int(line[i])
                if (num in state_3_choice):
                    state = 4
                    faculty += line[i]
                    i += 1
                else:
                    faculty = ''
                    state = 0
            except:
                faculty = ''
                state = 0
        elif (state == 4):
            if (line[i] == '-'):
                faculty += line[i]
                state = 5
                i += 1
            else:
                faculty = ''
                state = 0
        elif (state == 5):
            try:
                num = int(line[i])
                if (num in state_5_choice):
                    state = 6
                    faculty += line[i]
                    i += 1
                else:
                    faculty = ''
                    state = 0
            except:
                faculty = ''
                state = 0
        elif (state == 6):
            try:
                num = int(line[i])
                if (num in state_6_choice):
                    state = 7
                    faculty += line[i]
                    i += 1
                else:
                    faculty = ''
                    state = 0
            except:
                faculty = ''
                state = 0
        elif (state == 7):
            if (line[i] in state_7_choice):
                faculty += line[i]
                result.update({i - len(faculty) + 1: faculty})
                state = 0
                faculty = ''
                i += 1
            else:
                faculty = ''
                state = 0
    return result