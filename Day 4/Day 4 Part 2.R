##See Day 4.R for a description of how all the functions work. 
##Descriptions here will be of how the functions are modified
mark_board <- function(target, boards){
  marked_boards = boards[,]
  boards_to_mark = which(marked_boards == target)
  input_length = dim(marked_boards)[1]
  for (i in boards_to_mark){
    row = i%%input_length
    col = find_position(i, input_length)
    marked_boards[row,col] = marker
  }
  return(marked_boards)
}

#We ended up having to clean up this function.
#Since we will be removing boards from play our number of rows in our df will be changing.
#This function was changed to accomodate that
find_position <- function(value, total_rows){
  pos = 0
  for (i in board_ncol:1) {
    if (value <= total_rows*i){
      pos = i
    }
  }
  return(pos)
}


#Again the number of rows will be changing. This function was updated to reflect that
check_for_bingo <- function(boards){
  winning_board = c()
  winning_board_length = dim(boards)[1]
  for(i in seq(1,winning_board_length, by=board_ncol)){
    for (j in 0:(board_ncol-1)){
      #          This checks a for bingo                         this checks a column bingo
      if(   !any(boards[i+j, c(1:board_ncol)] != marker) || !any(boards[c(i:(i+4)), j+1] != marker)){
        winning_board = c(winning_board, i)
      }
    }
  }
  return(unique(winning_board)) #In case a board got added twice for having a 'double bingo'
}#Function returns NULL if no bingo is found


sum_winning_board <- function(boards, sum_board, winning_number){
  ans = c()
  for (b in sum_board){
    board_score = 0
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

#We added this function to remove boards
remove_board <- function(boards, BINGO){
  still_in_play = boards[,]
  #Our list of BINGO's is sorted by design. Let's reverse the order of the list so we are removing boards from the bottom up to avoid any indexing errors
  BINGO = rev(BINGO) 
  for (i in BINGO){
    still_in_play = still_in_play[c(-i:-(i+4)),]
  }
  return(still_in_play)
}
#Our solution function now uses remove_board after creating a list of winning_board indexes
#Before it removes the boards it checks to see if it is removing the last board in play.
#If so, it calls the sum_winning_board function to generate a score to get the answer to our challenge.
solution <- function(bingo_boards, chosen_numbers){
  boards_in_play = bingo_boards[,]
  for (i in chosen_numbers){
    boards_in_play = mark_board(i, boards_in_play)
    #A vector containing positions of winning boards
    winning_board = check_for_bingo(boards_in_play) 
    
    if(!is.null(winning_board)){
      #Check to see if winning board is the last board
      if(dim(boards_in_play)[1] == 5){
        ans = sum_winning_board(boards_in_play, winning_board, i)
        return(ans)
      }
      boards_in_play = remove_board(boards_in_play, winning_board)
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