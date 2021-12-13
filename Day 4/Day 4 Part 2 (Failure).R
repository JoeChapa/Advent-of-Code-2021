##See Day 4.R for a description of how all the functions work. 
##Descriptions here will be of how the functions are modified
mark_board <- function(target, boards){
  marked_boards = boards[,]
  boards_to_mark = which(marked_boards == target)
  input_length = dim(boards)[1]
  for (i in boards_to_mark){
    row = i%%input_length
    col = find_position(i, input_length)
    marked_boards[row,col] = marker
  }
  return(marked_boards)
}


find_position <- function(value, total_rows){
  pos = 0
  for (i in board_ncol:1) {
    if (value <= total_rows*board_ncol){
      pos = board_ncol
    }
  }
  return(pos)
}


#This function has been modified. If a bingo is found, the board is removed from the list
check_for_bingo <- function(boards){
  still_in_play = boards[,]
  still_in_play_length = dim(still_in_play)[1]
  #for(i in seq(1,number_of_boards,by=board_ncol)){
  for(i in seq(1, still_in_play_length, by=board_ncol)){
    for (j in 0:(board_ncol-1)){
      #               This checks a for bingo                         this checks a column bingo
      #print(still_in_play[i+j, c(1:board_ncol)] != marker)
      #print(still_in_play[c(i:(i+4)), j+1])
      print(dim(still_in_play))
      if(   !any(still_in_play[i+j, c(1:board_ncol)] != marker) || !any(still_in_play[c(i:(i+4)), j+1]!= marker)){
        still_in_play = still_in_play[c(-i:-(i+4)),]
      }
    }
  }
  #print(still_in_play[1:10,])
  return(still_in_play)
}#Function returns NULL if no bingo is found

#This function takes the winning boards and using advent of code's calculations to produce a score

sum_winning_board <- function(boards, sum_board, winning_number){
  ans = c()
  for (b in sum_board){
    board_score = 0
    #print(b)
    #print(boards[b:(b+4),c(1:5)])
    for(i in 0:(board_ncol-1)){
      for (j in 1:board_ncol){
        if(boards[b+i, j] != marker){
          board_score = board_score + as.integer(boards[b+i,j])
        }
      }
    }
    ans = c(ans, winning_number, board_score, winning_number*board_score)
  }
  return(matrix(ans, byrow = TRUE, ncol = 3))
}

#finally we have our solution or "main method" where all the work is done
solution <- function(bingo_boards, chosen_numbers){
  boards_in_play = bingo_boards[,]
  for (i in chosen_numbers){
    boards_in_play = mark_board(i, boards_in_play)
    boards_in_play = check_for_bingo(boards_in_play)
    #This if statement means only 1 board remains
    if(dim(boards_in_play)[1] == board_ncol){ 
      ans = sum_winning_board(boards_in_play, 1, i)
      #print(ans)
    }
  }
  #return(tail(ans,3))
}

#Now we can import our data
chosen_numbers = scan(file="E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 4\\chosen numbers.txt", sep=",")
bingo_boards = read.table("E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 4\\bingo boards.txt")
#Create some global variables that are handy to use
board_ncol = dim(bingo_boards)[2]
input_length = dim(bingo_boards)[1]
number_of_boards = input_length/board_ncol
marker = '*'
#and call our solution method to solve our problem
#For Part 2, all we have to do is remove the if statement from solution.
#This means our function will run until all boards are marked
#We can then check the last board in winning_boards and call the sum function on that

solution(bingo_boards, chosen_numbers)
test = c(1,2,3)
test[-1]
tail(test,1)

gg = matrix(c(2,3,4,5,6,7,8,3,5), byrow=TRUE, ncol=3)
gg[c(-1:-2),]

x# ans is too high 20000
