file = open("Day 3 Input.txt", 'r')
input = file.readlines()

total_entries = len(input)
#print(len(input[0]))

#First let's see how long each entry is
entry_len = len(input[0].strip())

#Now that we know each entry is 13 digits long, let's create an array.
#We want each array entry to corrospond the bit position of the entry
count_1s = [0 for x in range(entry_len)]

#Let's count all the 1 in every bit position
for entry in input:
    for i in (range(0, entry_len)):
        if entry[i] == '1':
            count_1s[i] = count_1s[i] + 1

#Now we have a list with the number of 1's in each column
gamma_rate = ""
epsilon_rate = ""

for bit in count_1s:
    if bit > total_entries/2:
        gamma_rate = gamma_rate + "1"
        epsilon_rate = epsilon_rate + "0"
    else:
        gamma_rate = gamma_rate + "0"
        epsilon_rate = epsilon_rate + "1"

#Convert our rates to binary
gamma_rate = int(gamma_rate,2)
epsilon_rate = int(epsilon_rate,2)

print(gamma_rate, epsilon_rate, '/n', gamma_rate*epsilon_rate)