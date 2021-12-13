#I want to create 3 functions to help us solve this challenge.
#Our first function go through the bingo boards and check to see if they contain the target number
#If the board does contain the target number our second function will mark that board
#After marking every board, we need a third funciton to go through each board and check to see if has a bingo or not


chosen_numbers = scan(file="E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 4\\chosen numbers.txt", sep=",")
boards = read.table("E:\\Users\\Rondo\\Documents\\Advent of Code 2021\\Day 4\\bingo boards.txt")

#Let's go ahead and create some global variables our functions will use
board_size = dim(boards)[2]
num_of_boards = dim(boards)[1]/board_size
marker = '*'
#This funciton searches a board for the target number and marks it if found
#This functions returns a vector containing the index of all boards changed
search_board_mark_target <- function(target, board_index, boards){
  for (i in 0:(board_size-1)){
    for (j in 1:board_size){
      if (boards[board_index+i,j] == target){
        boards[board_index+i,j] = marker
        return(c(TRUE, boards))
        }
    }
  }
  return(FALSE)
}

check_for_bingo <- function(boards_to_check, board_list){
  bingo = FALSE
  winning_condition = c(rep(marker, board_size))
  winning_board = c()
  for (b in boards_to_check) {
    pos = b
    for (i in 0:(board_size-1)){
      #                 This checks the row for bingo                                   this checks a column bingo
      if(   (board_list[pos+i,c(seq(1,board_size))] ==  winning_condition || board_list[c(seq(pos, pos+5)), i+1]) ==  winning_condition ){#if
        bingo = TRUE
        winning_board = c(winning_board, pos)
      }
    }
  }
  return(c(bingo, winning_board))
}#fun

score_board <- function(winning_number, board, board_list){
  return_ans = c()
  for (i in board) {
    board_to_sum = board_list[c(board:(board+board_size)),c(1:board_size)]
    board_sum = sum(as.integer(board_to_sum[which(board_to_sum != marker)]))
    return_ans = c(return_ans, winning_number, board_sum, winning_number*board_sum)
  }
  return(matrix(return_ans, byrow = T, ncol=3))
}

#Main method - Should be inside a do while
bingo_found = FALSE
while (bingo_found != TRUE){
  boards_being_played = data.frame(boards)
  for(i in 1:length(chosen_numbers)){
    target = chosen_numbers[i]
    modified_boards = c()
    for (board_index in seq(1,num_of_boards,by=board_size)){
      was_marked = search_board_mark_target(target, board_index, boards_being_played)
      if (was_marked[1] == TRUE){
        boards_being_played = was_marked[2]
        modified_boards = c(modified_boards,board_index)
        }#nested
    }
    result = check_for_bingo(modified_boards, boards_being_played)[1]
    bingo_found = result[1]
    winning_board = result[2]
    if(bingo_found == TRUE){
      ans = score_board(target, winning_board, boards_being_played)
      print(ans)
    break
    }
  }#for
}#while
