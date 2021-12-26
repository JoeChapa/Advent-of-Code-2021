
#Now Create a function to take the input data and turn it into a map_matrix
input_to_matrix <- function(input_data){
  matrix_vect = c()
  for (line in input_data){
    list_of_line = strsplit(line, "")
    for (i in list_of_line){
    matrix_vect = c(matrix_vect, as.numeric(i))
    }
  }
  
  num_of_col = length(matrix_vect)/length(input_data)
  return(matrix(matrix_vect, byrow = TRUE, ncol = num_of_col))
}

#This function takes a point in the map_matrix and returns a matrix referencing the point's valid neighbors 
check_neighbors <- function(map, row, col){
  max_rows = dim(map)[1]
  max_cols = dim(map)[2]
  neighbors = c()
  if (row-1>0){neighbors = c(neighbors, row-1, col) } #Check for North neighbor
  if (row+1<=max_rows) {neighbors = c(neighbors, row+1, col)} #Check for South neighbor
  
  if (col-1>0) {neighbors = c(neighbors, row, col-1)} #Check for West neighbor
  if (col+1<=max_cols) {neighbors = c(neighbors, row, col+1)} #Check for East neighbor
  return(matrix(neighbors, byrow = TRUE, ncol=2))
}

#Using the map_matrix, let's generate a matrix of all low points in the map
generate_low_points <- function(map_matrix){
  rows = dim(map_matrix)[1]
  cols = dim(map_matrix)[2]
  
  low_points = c()
  
  for (i in 1:rows){
    for (j in 1:cols){
      bool_vect = c()
      #Get a matrix of valid neighbors
      neighbors = check_neighbors(map_matrix, i, j)
      #For each point in the matrix, check to see if it is lower than all it's neighbors
      for (n in 1:dim(neighbors)[1]){
        neighbor_row = neighbors[n,1]
        neighbor_col = neighbors[n,2]
        bool_vect = c(bool_vect, map_matrix[i,j] < map_matrix[neighbor_row, neighbor_col])
      }
      if (!any(bool_vect == FALSE)){ low_points = c(low_points, c(i,j)) }
    }
  }
  return(matrix(low_points, byrow=TRUE, ncol=2))
}

#After finding the low points, let's create a function to sum the risk levels of a low point
generate_risk <- function(map, low_points){
  risk_score = 0
  points_len = dim(low_points)[1]
  for (i in 1:points_len){
    risk_score = risk_score + map[low_points[i,1],low_points[i,2]] + 1
  }
  return(risk_score)
}


#Let's run through part 1
input = scan('E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 9\\Day 9 Input.txt', what = character())
map = input_to_matrix(input)
dim(map)
lows = generate_low_points(map)
generate_risk(map, lows)


###Start part 2
#This function finds the lengths of of each basin
find_basins <- function(map, low_points){
 basin_lengths = c()
  for(i in 1:dim(low_points)[1]){
    basin_points = matrix(map_basin(map, low_points[i,1], low_points[i,2]), ncol=2, byrow=TRUE)
    #In order to avoid duplicate indicies, we have to call the unique function on our matrix
    size = dim(unique(basin_points))[1]
    basin_lengths = c(basin_lengths, size)
  }
 return(basin_lengths)
}


#This is a recursive function. It creates a vector of nodes conncting the basin
map_basin <- function(map, low_row, low_col ){
  basin_nodes = c(low_row,low_col)
  neighbors = check_neighbors(map, low_row, low_col)
  
  for(n in 1:dim(neighbors)[1]){
    if (map[low_row,low_col] < map[neighbors[n,1], neighbors[n,2]] && (map[neighbors[n,1], neighbors[n,2]] != 9)){
      new_nodes = map_basin(map, neighbors[n,1], neighbors[n,2]) 
      basin_nodes = c(basin_nodes, new_nodes, neighbors[n,1], neighbors[n,2])
    }
  }
  return(basin_nodes)
}

#Now let's run through part 2
basins = find_basins(map, lows)

#Now we just need to sort basins and get the largest 3
sorted_basins = sort(basins, decreasing = TRUE)
#sorted_basins[1:3]
sorted_basins[1] * sorted_basins[2] * sorted_basins[3]
