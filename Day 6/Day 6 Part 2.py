import math

#I have two ideas for the solution.
#First, we can try and calculate it using a list where each position corroponds to days left
#We create a recursive function that counts how many fish will be produced and then
#the function will call itself to calculate how many fish those offspring will produce until that number is 0
def solution(last_day, fish_list):
    total_fish = fish_list[:]
    #print(f'Inital conditions: {total_fish}')
    for i in range(0,last_day):
        total_fish = progress_day(total_fish)
        #print(f'Day {i+1}: {total_fish}')
    return(len(total_fish))

def progress_day(fish_list):
    end_of_day_list = fish_list[:]
    babies = 0
    for i in range(0,len(end_of_day_list)):
        if end_of_day_list[i] == 0:
            end_of_day_list[i] = 6
            babies += 1
        else:
            end_of_day_list[i] = end_of_day_list[i] - 1
    if len(babies) != 0:
        end_of_day_list += babies
    return end_of_day_list



input = open('Day 6 Input.txt', 'r')
input_list = input.readlines()
input.close()

list_len = math.ceil(len(input_list[0])/2)
initial_start = [int(input_list[0][i*2]) for i in range(0,list_len)]

#After is too big to loop through manually.
# We will instead have to calculate the number of fish
ans = solution(256, initial_start)
print(ans)