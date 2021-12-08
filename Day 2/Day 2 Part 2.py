#Import the input data
file = open("Day 2 Input.txt", 'r')
input = file.readlines()

#Create a 'vector' to keep track of the position and depth
position_depth_aim = [0,0,0]

#Create a for loop to cycle through the data
for instruction in input:
    #Split the instruction into the 'direction' and the 'change in amount'
    instruction_split = instruction.split()
    direction = instruction_split[0]
    displacement = int(instruction_split[1])

    #Flow control
    if direction == "down":
        position_depth_aim[2] = position_depth_aim[2] + displacement
    elif direction == "up":
        position_depth_aim[2] = position_depth_aim[2] - displacement
    else:
        position_depth_aim[0] = position_depth_aim[0] + displacement
        position_depth_aim[1] = position_depth_aim[1] + (position_depth_aim[2] * displacement)

#Close the file
file.close()

#Print the answer
print(position_depth_aim[0], position_depth_aim[1], position_depth_aim[2])
print(position_depth_aim[0]*position_depth_aim[1])
