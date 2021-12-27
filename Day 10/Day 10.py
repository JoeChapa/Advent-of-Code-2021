import math

file = open("Day 10 Input.txt", 'r')
input_text = file.readlines()
file.close()

#Let's create a global dictionary of what we are looking for
delim_dict = {
        '(': ')',
        '[': ']',
        '{': '}',
        '<': '>',
    }
#This function returns if the closing delimiter matches what is on the stack
def check_stack(stack, delim):
    delim_opener = stack[-1]
    return delim_dict[delim_opener] == delim

#This function returns the first delimiter that doesn't match the stack
def find_corrupted(input_line):
    stack = []
    for delim in input_line: #delim is short for delimiter
        if delim in ('(', '[', '{', '<'):
            stack.append(delim)
        else:
            if check_stack(stack, delim):
                stack.pop()
            else:
                return delim

#This function is used to calculate the score for the part 1
def score_syntax_errors(delims):
    syntax_score = {
        ')': 3,
        ']': 57,
        '}': 1197,
        '>': 25137,
    }
    score = 0
    for delim in delims:
        score += syntax_score[delim]
    return score


#This function was modified in part 2. It returns a list of corrupted delimiter and a list of incomplete lines
#The incomplete lines are not corrupted
def find_corrupted_incomplete(input_data):
    corrupted = []
    incomplete_lines = []
    for line in input_data:
        delims_to_score = find_corrupted(line.strip())
        if delims_to_score != None:
            corrupted.append(delims_to_score)
        else:
            incomplete_lines.append(line.strip())
    return corrupted, incomplete_lines

##########Function for part 2
#These functions where all created for part 2
#This function takes a list of opening delimiters and returns a list of the match closed delimiter in FIFO order
#FIFO = First In First out
def find_missing(input_line):
    stack = []
    for delim in input_line: #delim is short for delimiter
        if delim in ('(', '[', '{', '<'):
            stack.append(delim)
        else:
            if check_stack(stack, delim):
                stack.pop()
    #After we have our missing stack, we need to return the delimiters to complete our stack
    completed_stack = []
    for delim in stack:
        completed_stack.append(delim_dict[delim])
    return(completed_stack[::-1])

#This function creates a list of scores for part 2
def score_auto_complete(delims_list):
    auto_complete_dict = {
        ')': 1,
        ']': 2,
        '}': 3,
        '>': 4
    }
    score_list = []
    for entry in delims_list:
        score = 0
        for delim in entry:
            score = score * 5
            score += auto_complete_dict[delim]
        score_list.append(score)
    return score_list

#This is where our "Main method" for part 1 would start
corrupted_delims, incomplete_lines = find_corrupted_incomplete(input_text)
ans = score_syntax_errors(corrupted_delims)
print(f'Part 1 answer: {ans}')

#Main method for Part 2
missing_delims = []
for line in incomplete_lines:
    missing_delims.append(find_missing(line.strip()))

scores = score_auto_complete(missing_delims)
scores = sorted(scores)
middle_score_pos = math.floor(len(scores)/2)
part_2_ans = scores[middle_score_pos]
print(f'Part 2 answer: {part_2_ans}')