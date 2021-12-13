##First we have to convert the input given into a usualbe form
## I am going to be writing the 'cleaned input' to a csv and then I'll read that
input = read.delim("E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 5\\Day 5 Input.txt", header = FALSE)

library(stringr)
file_to_matrix <- function(convert_this){
  matrix_data = convert_this[,] 
  matrix_data = noquote(sub(" -> ", ",", matrix_data)) #This replaces the arrow with a ','
  matrix_data = str_split_fixed(matrix_data, ",", 4)
  matrix_data = as.numeric(matrix_data)
  return(matrix(matrix_data, byrow = FALSE, ncol = 4))
}

#For line segments for vents
vents = file_to_matrix(input)

#Now that we have our vent instructions, we need to create another matrix in order to keep track of the map
x_max = max(vents[,c(1,3)])
y_max = max(vents[,c(2,4)])
base_map = matrix(rep(0, x_max*y_max),
                  byrow=TRUE,
                  ncol = y_max)
print(x_max)
print(y_max)
#print(base_map)
#Lastly, all we have to do is run through our line segment instructions and update our map
solution <- function(line_seg, map){
  soln_map = map[,]
  num_of_segs = dim(line_seg)[1]
  for (i in 1:num_of_segs){
    x1 = line_seg[i,1]
    x2 = line_seg[i,3]
    y1 = line_seg[i,2]
    y2 = line_seg[i,4]
    if(x1 == x2){
      
      y_max = max(y1, y2)
      y_min = min(y1, y2)
      
      soln_map[x1, c(y_min:y_max)] = soln_map[x1, c(y_min:y_max)] + 1
    }
    if(y1 == y2){
      x_max = max(x1, x2)
      x_min = min(x1, x2)
      soln_map[c(x_min:x_max), y1] = soln_map[c(x_min:x_max),y1] + 1
    }
  }#for
return(soln_map)
}

ans = solution(vents, base_map)
ans_value = length(which(ans>=2))
ans_value 


##We never actually used any of this code b/c we never actually drew a map.
draw_map(ans)

find_position <- function(value, total_rows, total_col){
  pos = 0
  for (i in total_col:1) {
    if (value <= total_rows*i){
      pos = i
    }
  }
  return(pos)
}

draw_map <- function(map){
  new_map = map[,]
  rows = dim(new_map)[1]
  cols = dim(new_map)[2]
  zero_to_dot = which(new_map == 0)
  for (i in zero_to_dot){
    y = find_position(i, rows, cols)
    new_map[i%%rows,y] = "."
  }
  print(noquote(new_map[]))
}

