#Import packages
from math import ceil

#Read input data from file
file = open("Day 14 Input.txt", 'r')
data = file.readlines()
file.close()

##Let's define some methods we will need to solve this problem
'''
This function takes the raw data from the input file as a parameter. 
It creates and returns a dictionary. 
The keys are all 'pairs' from the polymer template
The values are the number of times the 'pair' occurs 
'''
def create_polymer_template_dict(raw_data):
    template_dict = {}
    template = raw_data[0].strip()
    for i in range(0, len(template) - 1):
        pair = template[i] + template[i + 1]
        if pair not in template_dict.keys():
            template_dict[pair] = 1
        else:
            template_dict[pair] = template_dict[pair] + 1
    return template_dict
'''
This function takes the raw data from the input file as a parameter. 
It creates and returns a dictionary for the 'pair insertion rules'. 
'''
def create_pair_insertion_dict(raw_data):
    insert_dict = {}
    for line in raw_data:
        if " -> " in line:
            pair, to_insert = line.strip().split(" -> ")
            insert_dict[pair] = to_insert
    return insert_dict

'''
This function takes a dictionary as a parameter.
It returns a nested list containing each unique character and the number of occurances
'''
def count_elements(template):
    counted_dict = {}
    for key in template.keys():
        for ch in key:
            #print(f"key: {key}, ch: {ch}")
            #print(template[key])
            if ch not in counted_dict.keys():
                counted_dict[ch] = template[key]
            else:
                counted_dict[ch] += template[key]

    counted_list = list(counted_dict.items())
    counted_list.sort(key=lambda y: y[1], reverse=True)
    return counted_list
'''
This function takes a polymer template dictionary and a pair insertion rules dictionary as parameters
The function creates uses the 'pair rule dictionary' to a step through the polymer template dictionary
This function returns a dictonary representation of 'pairs' generated  
'''
def step_through_process(poly_dict, pair_dict):
    updated_dict = {}
    #Given a poly_template, we have to find what values will be returned
    for key in poly_dict.keys():
        middle_ch = pair_dict[key]
        #We also need to find how many times that pair appears in the template
        occurance = poly_dict[key]
        #Now, we need to add 2 keys to our new template. One pair for the left side of the inserted char, and one for the right side
        for new_pair in (key[0]+middle_ch, middle_ch+key[1]):
            if new_pair not in updated_dict.keys():
                updated_dict[new_pair] = occurance
            else:
                updated_dict[new_pair] += occurance
    return(updated_dict)


'''This function acts as the main function that drives all of our code'''
def ans(n, data):
    # First let's create a pair_insertion dictionary from the rest of the input data
    template_step = create_polymer_template_dict(data)
    pair_dict = create_pair_insertion_dict(data)

    for i in range(1, n + 1):
        template_step = step_through_process(template_step, pair_dict)

    counted_elements = count_elements(template_step)
    most_common_minus_least_common = counted_elements[0][1] - counted_elements[-1][1]
    return(ceil(most_common_minus_least_common/2))


print(f'Answer to part 1: {ans(10, data)}')
print(f'Answer to part 2: {ans(40, data)}')