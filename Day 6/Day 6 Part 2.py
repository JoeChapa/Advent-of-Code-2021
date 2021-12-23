import math

#After reviewing the example output on the website, we observe that every 7 days the fish reproduction timers mirror the initial condition.
#Hence we will create this global variable named cycle
CYCLE = 7



def solution(last_day, fish_list):
    total_fish = fish_list[:]
    cycle_after = last_day%CYCLE #We have to cycle this many times in order to end on last_day
    for i in range(0,cycle_after):
        total_fish = progress_day(total_fish)

    #Now let's figure out the rest of the days to cycle on
    cycle_days = [x*CYCLE for x in range(1, (int(last_day/CYCLE))+1)]
    
    #Now all we have to do is repeat the cycle and calculate the offspring every cycle
    num_of_offspring = progress_cycle(total_fish, cycle_days)
    return(num_of_offspring)

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

#After reviewing the example again, we see that after 7 days an 8 -> 1, 7 -> 2, etc.
#We will create a dictionary to represent this relationship
def progress_cycle(fish_list, cycle_list):
    cycle_dict = {
        8: 1,
        7: 0,
        6: 8,
        5: 7,
        4: 6,
        3: 5,
        2: 4,
        1: 3,
        0: 2,
    }
    offspring_list = fish_list[:]
    offspring_count = len(fish_list)
    #print(f'initial count: {offspring_count}')
    
    #Let's create a list where the position of the list keeps count of the number of fish.
    #Example. position 0 keeps track how many fish are currently on day 0 of their reproductive cycle.
    count_offspring = [0 for x in range(0, 9)]
    #print(f'IC: {offspring_list}')
    
    #Let's initialize the list based on our input data
    for o in offspring_list:
        count_offspring[o] += 1
    #print(count_offspring)
    #Let's cycle through the remaining days
    for i in cycle_list:  
        
        next_offspring = count_offspring[:] #Initialize a new temp list. The data inside doesn't matter. It only has to be the same length as count_offspring
        for l in range(0, 9):
            #We putting data into our temp list based on the relationship dict
            next_offspring[cycle_dict[l]] = count_offspring[l]
            if l >= 7:
                count_offspring[l] -= count_offspring[l]#Note: A 7 or 8 fish doesn't produce any babies. Hence we have to reduce the count
        '''
        print(f'count{count_offspring}')
        print(f'next_offspring {next_offspring}')
        '''
        count_offspring = [count_offspring[u]+next_offspring[u] for u in range(0,len(count_offspring))]
        #print(f'{sum(count_offspring)}   {count_offspring}\n')
    return sum(count_offspring)  # Changed from offspring_count
   

input = open('Day 6 Input.txt', 'r')
input_list = input.readlines()
input.close()

list_len = math.ceil(len(input_list[0])/2)
initial_start = [int(input_list[0][i*2]) for i in range(0,list_len)]

#After is too big to loop through manually.
# We will instead have to calculate the number of fish
ans = solution(256, initial_start)
print(ans)