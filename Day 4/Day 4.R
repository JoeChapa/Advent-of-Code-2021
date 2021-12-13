#We have to create a couple funtions in order to solve this challenge

#This first funciton will take a target number to search for and a list of boards to search and will mark each target
#Using which() returns a vector of integers where the target was found
#We can turn this single int into a possition on the data frame if we modulus(5)  to get the row. We have written a function to get the column 
mark_board <- function(target, boards){
  marked_boards = boards[,]
  boards_to_mark = which(marked_boards == target)
  for (i in boards_to_mark){
    row = i%%input_length
    col = find_position(i)
    marked_boards[row,col] = marker
    }
  return(marked_boards)
}

#Since our bingo boards input_length is 500 that means any number > 500 is in column 1
# anything between 501 and 1000 is in column 2, etc.
#This funciton could be better written using a for-loop and using variables instead of explicit values,
#but I like the readability of this function
find_position <- function(value){
  pos = 0
  if (value <= 2500){pos = 5}
  if (value <= 2000){pos = 4}
  if (value <= 1500){pos = 3}
  if (value <= 1000){pos = 2}
  if (value <= 500){pos = 1}
  return(pos)
}

#This function takes a data frame of boards and returns a list of winning boards (in case multiple ppl win the same round)
check_for_bingo <- function(boards){
  winning_board = c()
  #for(i in seq(1,number_of_boards,by=board_ncol)){
  for(i in seq(1,input_length, by=board_ncol)){
    for (j in 0:(board_ncol-1)){
      #     This checks a for bingo                         this checks a column bingo
      if(   !any(boards[i+j, c(1:board_ncol)] != marker) || !any(boards[c(i:(i+5)), j+1]!= marker)){
        winning_board = c(winning_board, i)
      }
    }
  }
  return(winning_board)
}#Function returns NULL if no bingo is found

#This function takes the winning boards and using advent of code's calculations to produce a score
sum_winning_board <- function(boards, sum_board, winning_number){
  ans = c()
  for (b in sum_board){
    board_score = 0
    print(b)
    print(boards[b:(b+4),c(1:5)])
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
    winning_board = check_for_bingo(boards_in_play) 
    
    if(!is.null(winning_board)){
      print(i)
      ans = sum_winning_board(boards_in_play, winning_board, i)
      print(ans)
      return(ans)
    }
  }
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
solution(bingo_boards, chosen_numbers)

