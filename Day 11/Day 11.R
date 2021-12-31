#Let's create a funciton to take our input data and turn it into a matrix
input_to_matrix <- function(input_data){
  matrix_vect = c()
  for (line in input_data){
    line_list = strsplit(line, "")
    for (i in line_list){
      matrix_vect = c(matrix_vect, as.numeric(i))
    }
  }
  num_of_col = length(matrix_vect)/length(input_data)
  return(matrix(matrix_vect, byrow = TRUE, ncol = num_of_col))
}

#This function takes the value from a length(matrix) vector and converts it to the col which contains the value
find_col_pos <- function(value, total_rows, total_col){
  pos = 0
  for (i in total_col:1) {
    if (value <= total_rows*i){
      pos = i
    }
  }
  return(pos)
}

#Updates the entire grid 1 step
update_grid <- function(grid){
  #First, we addd 1 to all values in the grid
  updated_grid = grid[] + 1
  
  #We can then get the dimensions of the matrix which will come in handy later
  max_row = dim(grid)[1]
  max_col = dim(grid)[2]
  
  #Any fish with value higher than or equal to 10 will flash
  increase_neighbors = which(updated_grid >= 10)
  while (length(increase_neighbors != 0)) {
    #Now that we have a vector of positions in the matrix, we have to convert it to an [i,j] format
    i = c(increase_neighbors%%max_row) 
    to_10 = which(i==0) #We have to convert 0's to 10 
    i[to_10] = 10
    j = c()
    for (n in increase_neighbors){
      j = c(j, find_col_pos(n, max_row, max_col))
    }
    
    #Now that we have the position of the flashing fish, we will work our way through the i,j vectors and get the neighbors of the flashing fish
    for (o in 1:length(i)){
      neighbors = get_neighbors(i[o], j[o], max_row, max_col)
      updated_grid = increase_grid_neighbors(updated_grid, neighbors)
      #In order to prevent fish flashing multiple times, we set the value of the fish negative
      #Therefore they won't appear in the which(updated_grid >= 10)
      #We can also safely assume that the fish can't be increased to 0 since at most a fish has 8 neighbors and the floor for our value is -10
      updated_grid[i[o], j[o]] = -updated_grid[i[o], j[o]]
    }
    increase_neighbors = which(updated_grid >= 10)
  }
  
  #Now that there are no more flashing fish that need to be updated, we can turn the 
  updated_grid_data = as.vector(updated_grid)
  flashes = which(updated_grid_data < 0 )
  updated_grid_data[flashes] = 0
  return(matrix(updated_grid_data, ncol=max_col, byrow=FALSE))
}

#This function takes a grid and a list of neighbors and returns an updated grid with the neighbors nodes increased
increase_grid_neighbors <- function(grid, neighbors){
  update_grid_neighbors = grid[]
  for (s in neighbors$row){
    for (t in neighbors$col){
      update_grid_neighbors[s, t] = update_grid_neighbors[s, t] +1
    }
  }
return(update_grid_neighbors)
}

#This function returns a list of neighbors
get_neighbors <- function(base_row, base_col, row_limit, col_limit){
  row = c(base_row:(base_row+2)-1)
  col = c(base_col:(base_col+2)-1)
  #we need to filter out out-of-bounds entries
  row = row[ row %in% 1:row_limit]
  col = col[ col %in% 1:col_limit]
  return(list(row=row, col=col))
}

#This function returns the solution to part 1
part_1_soln <- function(grid, nsteps){
  ans_grid = grid[]
  ans = 0
  for (i in 1:nsteps){
    ans_grid = update_grid(ans_grid)
    ans = ans + length(which(ans_grid == 0))
  }
  return(ans)
}

input_data = scan(file="E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 11\\Day 11 Input.txt", what = character())
octo_grid = input_to_matrix(input_data)
part_1_soln(octo_grid, 100)

###Begin Part 2

#We will modify the part 1 solution function to be a  while loop and stop when all grid values are synchronized
#Note that the only way for values to increase is for a fish to flash. This means the values have to synchronize on 0
part_2_soln <- function(grid){
  ans_grid = grid[]
  total_sync = length(grid)
  ans = 0
  
  is_synchronized = FALSE
  while (!is_synchronized){
    ans_grid = update_grid(ans_grid)
    ans = ans + 1
    snyced = length(which(ans_grid == 0))
    if(total_sync == snyced){
      return(ans)
    } 
  }
}
part_2_soln(octo_grid)
