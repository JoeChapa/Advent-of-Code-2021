#First let's get our input data
file = open("Day 8 Input.txt", 'r')
input_text = file.readlines()
file.close()

#print(input_text)
def return_match(search, target):
    for i in search:
        bool_list = [i.find(x) >= 0 for x in target]
        #print(bool_list)
        if False not in bool_list:
            return(i)
#This function takes a list, sorts all the strings and returns a sorted list
def alphabatize_list(unsorted_list):
    sorted_list = []
    for key in unsorted_list:
        sorted_key = sorted(key)
        sorted_string = ''.join(sorted_key)
        sorted_list.append(sorted_string)
    return sorted_list

def create_key(cipher):
    key = [None] * 10
    cipher = sorted(cipher, key=lambda x: len(x)) #Sort the cipher by string length
    #We know 1 is will be the first element, and 8 the last
    key[1] = cipher[0]
    key[7] = cipher[1]
    key[4] = cipher[2]
    key[8] = cipher[-1]
    #We know that 2,3,5 all have length 5, but 3 is the only number that uses all of 1's signals
    list_1 = [x for x in key[1]]

    len_5 = cipher[3:6]
    key[3] = return_match(len_5, list_1)
    len_5.remove(key[3])

    #Now that we have figured out 3, we have 2 and 5 left for the strings of length 5
    #If we subtract 1's letters from 4 we can figure out the number 5
    list_4 = [x for x in key[4]]

    for y in list_1:
        list_4.remove(y)
    key[5] = return_match(len_5, list_4)
    len_5.remove(key[5])
    key[2] = len_5[0]

    #Now we have to deal with the length 6 strings
    len_6 = cipher[6:9] #lol

    #We know 3 has all the signals of 9
    key[9] = return_match(len_6, [x for x in key[3]])
    len_6.remove(key[9])

    #The last two numbers are 0 and 6. We know that 0 contains signals from 1
    key[0] = return_match(len_6, list_1)
    len_6.remove(key[0])
    #Lastly, all we have left is 6
    key[6] = len_6[0]

    return key

#Let's seperate our input data into the 10 digit 'key string' and the 'display string'
count_unique = 0
for entry in input_text:
    display_key = [x for x in entry.split()[:10]]
    display_text = [x for x in entry.split()[11:]]
    display_key = sorted(display_key, key=lambda x: len(x))
    #print(display_key)

    new_key = alphabatize_list(display_key)
    key = create_key(new_key)
    #print(key)
    new_display_text = alphabatize_list(display_text)
    generate_display = [key.index(text) for text in new_display_text]
    #print(generate_display)
    for digit in generate_display:
        if digit in (1,4,7,8) :
            count_unique += 1
print(count_unique)