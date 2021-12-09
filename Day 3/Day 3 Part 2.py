import operator

file = open("Day 3 Input.txt", 'r')
input = file.readlines()
file.close()

#Continuing from Part 1, we still want to keep the legnth of each entry
entry_len = len(input[0].strip())

#After brainstorming, we can set up 3 functions to help us figure out this problem.
#1) Our first function needs to filter the list
def filter_list(unfiltered, pos, term):
    filtered_list = []
    for entry in unfiltered:
        if entry[int(pos)] == str(term): #Convert pos to int and term to string
            filtered_list.append(entry.strip())
    return filtered_list

#2) Our second function needs to take a list and count all the 0's and 1's in the position we specify
def count_values(list, pos):
    temp_counts = [0, 0]
    for entry in list:
        if entry[int(pos)] == '0':
            temp_counts[0] += 1
        else:
            temp_counts[1] += 1
    return temp_counts

#3) Our third function needs the diagnostic value and if we are searching for the most common or least common term
def generate(diagnostic, mode, func_input):
    ops = {
        'most': operator.ge,
        'least': operator.lt,
    }
    ops_func = ops[mode]
    temp_list = func_input[:] #Create a clone of the list to be filtered
    for i in (range(0, entry_len)):
        temp_list = filter_list(temp_list, i, diagnostic[i])
        if len(temp_list) == 1:
            break
        #Get the 0's and 1's count of the next position
        next_count = count_values(temp_list, i+1)
        #Do the evaluation based on mode argument
        if ops_func(next_count[1],next_count[0]):
            diagnostic += '1'
        else:
            diagnostic += '0'
    return temp_list[0].strip()#[diagnostic, temp_list] #

#We are now ready to evaluate and solve
#We know from part 1 that the first column has more 0's than 1's
oxygen_rate = "0"
CO2_rate = "1"

oxygen_rate = generate(oxygen_rate, 'most', input)
CO2_rate = generate(CO2_rate, 'least', input)

#Convert our rates from string to binary
oxygen_rate = int(oxygen_rate,2)
CO2_rate = int(CO2_rate,2)

#Print the solution
print(oxygen_rate, CO2_rate, f'\n{oxygen_rate*CO2_rate}')
