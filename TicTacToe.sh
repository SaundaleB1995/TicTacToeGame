#!/bin/bash
     echo "Welcome to Tic Tac Toe Game"

   row=3
column=3

declare -A game_Board
function resettingBoard()
{
    for ((i=0;i<row;i++))
    do
      for((j=0;j<column;j++))
      do  game_Board[$i,$j]="-"
      done
    done
}

function displayGameBoard() {
	echo "               "
	for((i=0; i<row; i++))
	do
		for((j=0; j<column; j++))
		do
			echo -n " ${game_Board[$i,$j]} |"
		done
		echo
		echo "               "
	done
}

resettingBoard
displayGameBoard
