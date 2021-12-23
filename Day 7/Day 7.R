input = scan(file="E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 7\\Day 7 Input.txt", sep=",")


#Let's get a list of each crab position
crab_pos = unique(input)

#For each position we will calculate the fuel cost
fuel_cost = c()
for (crab in min(crab_pos):max(crab_pos)){
  fuel_cost = c(fuel_cost, sum(abs(input - crab)))
}
#Now we return the minimum fuel_cost
ans = min(fuel_cost)
ans




##Part 2

crab_pos = unique(input)
#For each position we will calculate the fuel cost
fuel_cost = c()
for (crab in min(crab_pos):max(crab_pos)){
  distance_between_pos = abs(input-crab)
  mid_pos = (distance_between_pos+1)/2
  fuel_cost = c(fuel_cost, sum(distance_between_pos*mid_pos))
}
#Now we return the minimum fuel_cost
ans = min(fuel_cost)
ans

#Here is an example case of how the for-loop above works
#It is based off the fact you can calculate sum of a series by finding the mid-value of a series and multiplying by the number of elements in the series
# m = 16
# n = 5
# elements = m-n
# mid_value = (elements+1)/2
# elements*mid_value

