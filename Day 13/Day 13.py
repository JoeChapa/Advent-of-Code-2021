import numpy as np

#Let's get our input data
file = open('Day 13 Input.txt', 'r')
data = file.readlines()
file.close()

#Let's define our functions
#This reads from the input file and returns a list of dots positions and a list of fold instructions
def split_instructions(input_data):
    dots = []
    folds = []
    for line in data:
        if ',' in line and len(line) != 0:
            dot = line.strip().split(',')
            dot[0], dot[1] = int(dot[0]), int(dot[1])
            dots.append(dot)

        if "=" in line:
            index = len("fold along ")
            fold = line.strip()[index:]
            fold = fold.split('=')
            #Change right side to int
            fold[1] = int(fold[1])
            folds.append(fold)
    return dots, folds

#This function takes the dots list and return the max value of each dimension, aka the length of the paper
def paper_dim(dots):
    dim = [0,0]
    for dot in dots:
        for pos in (0,1):
            if int(dot[pos]) > dim[pos]:
                dim[pos] = int(dot[pos])
    return dim

#This function takes a list of dots and applies folds to them
def fold_paper(dots, folds):
    paper = dots[:]
    for fold in folds:
        #First, lets figure out with axis we are folding on. This will determine which dots we are changing
        if fold[0] == 'x':
            axis = 0
        else:
            axis = 1
        #Now we need to find the value of the fold
        val = fold[1]

        for dot in paper:
            #Dots after the axis-value need to be adjusted
            if dot[axis] > val: #If a dot is past the fold-point it needs to be adjusted
                dot[axis] = val - (dot[axis] - val)
            if dot[axis] == val: #If a dot is on the fold point, it needs to be removed
                paper.remove(dot)
    return paper

def unique_dots_on_paper(nested_list):
    unique_list = []
    for element in nested_list:
        if element not in unique_list:
            unique_list.append(element)
    return unique_list

def draw_paper(dots):
    dim = paper_dim(dots)
    map = np.full((dim[1]+1, dim[0]+1), '-', dtype='U') #'U' for unicode string. The +1 is b/c indexing at 0
    for dot in dots:
        map[(dot[1], dot[0])] = '#'
    return map


#We have to seperate the dot locations from the fold instructions
dots, folds = split_instructions(data)

#Let's fold our paper
#We are instructed to only fold our paper once in Part 1
paper = fold_paper(dots, [folds[0]])

#Laslty, we have to find all unique dots on our paper
visible_dots = len(unique_dots_on_paper(paper))
print(f'Answer to part 1: {visible_dots}')


#Begin Part 2
code_paper = fold_paper(dots, folds)
code_dots = unique_dots_on_paper(code_paper)
code = draw_paper(code_dots)
#We have to change the print option so each array entry prints on a single line
np.set_printoptions(linewidth=200)
print(code)
#Code is RPCKFBLR