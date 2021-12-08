input = read.table("E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 1 Input.csv")
colnames(input) = 'Depth'

#Check to see if the data imported correclty
head(input)



## Count the number of increases
input_length = dim(input)[1]-1
##Create a variable to keep track of how many times the depth increases
depth_increase = 0

for(i in 1:input_length){
  a = input[i,1]
  b = input[i+1,1]
  if (b-a > 0) {depth_increase = depth_increase + 1}
}#end loop 

print(depth_increase)
