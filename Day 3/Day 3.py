file = open("Day 3 Input.txt", 'r')
input = file.readlines()
file.close()

#First let's see how many entries there are and how long each entry is
total_entries = len(input)
entry_len = len(input[0].strip())

#Now that we know each entry is 12 digits long, let's create an list.
#We want each list entry to corrospond the bit position ['bit 1', 'bit2', etc]
count_1s = [0 for x in range(entry_len)]

#Let's count all the 1 in every bit position
for entry in input:
    for i in (range(0, entry_len)):
        if entry[i] == '1':
            count_1s[i] = count_1s[i] + 1
#print(count_1s) #Use is to figure out if the first column has more 1's or 0's for Day 3 Part 2

#Now we have a list with the number of 1's in each column
#Let's create some variables to store our binary number in string form
gamma_rate = ""
epsilon_rate = ""

#Note, we know that the number of entries is 1000
#Therefore, if count_1s is over 500 we know it is the most common bit
#meaning we add a 1 to the gamma rate and a 0 to the epsilon rate
for bit in count_1s:
    if bit > total_entries/2:
        gamma_rate = gamma_rate + "1"
        epsilon_rate = epsilon_rate + "0"
    else:
        gamma_rate = gamma_rate + "0"
        epsilon_rate = epsilon_rate + "1"

#Convert our rates from string to binary
gamma_rate = int(gamma_rate,2)
epsilon_rate = int(epsilon_rate,2)

#Print the solution
print(gamma_rate, epsilon_rate, f'\n{gamma_rate*epsilon_rate}')