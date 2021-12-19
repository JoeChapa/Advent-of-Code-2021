import math
#This function takes two arguments.
#Last day defines how many days we should progress through
#fish_list is the initial list of fish
def solution(last_day, fish_list):
    total_fish = fish_list[:]
    #print(f'Inital conditions: {total_fish}')
    for i in range(0,last_day):
        total_fish = progress_day(total_fish)
        #print(f'Day {i+1}: {total_fish}')
    return(len(total_fish))

def progress_day(fish_list):
    end_of_day_list = fish_list[:]
    babies = []
    for i in range(0,len(end_of_day_list)):
        if end_of_day_list[i] == 0:
            end_of_day_list[i] = 6
            babies.append(8)
        else:
            end_of_day_list[i] = end_of_day_list[i] - 1
    if len(babies) != 0:
        end_of_day_list += babies
    return end_of_day_list


#First, let's gather our input data
input = open('Day 6 Input.txt', 'r')
input_list = input.readlines()
input.close()


#Our input is going to be read as a string list.
#For our application, we have to convert it to an int list
#Each item in our list is seperated by a comma, therefore we want all even positions
list_len = math.ceil(len(input_list[0])/2)
initial_start = [int(input_list[0][i*2]) for i in range(0,list_len)]

#Now that we have a int list with inital conditions
# All we have to do is call a function to progress the day
ans = solution(256, initial_start)
print(ans)