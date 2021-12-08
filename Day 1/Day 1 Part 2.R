input = read.table("E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 1\\Day 1 Input.csv")
colnames(input) = 'Depth'

#Check to see if the data imported correclty
head(input)

## Count the number of increases
##Note, now we need to find increases in multiples of 3.
##In order to create a number divisible by 3 we can subtract the length modulus 3 from our input_length
input_length = dim(input)[1] - (dim(input)[1])%%3

##Create a variable to keep track of how many times the depth increases
depth_increase = 0

for(i in 1:input_length){
  a = sum(input[c(i, i+1, i+2), 1])
  b = sum(input[c(i+1, i+2, i+3), 1])
  if (b-a > 0) {depth_increase = depth_increase + 1}
}#end loop 

print(depth_increase)
