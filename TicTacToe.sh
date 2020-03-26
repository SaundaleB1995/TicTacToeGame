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

    function assignedLetter() {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		player="X"
		computer="O"
	else
		player="O"
		computer="X"
	fi
	echo "Assigned Player Letter: " $player
	echo "Assigned Computer Letter: " $computer
}


function checkPlayer() {
	if [ $((RANDOM%2)) -eq 0 ]
	then
		flag=0
		echo "Player Play First"
	else
		flag=1
		echo "Computer Play First"
	fi
}
checkPlayer

function displayGameBoard() {
	for((i=1;i<=row;i++))
	do
		echo ""
		echo -n "|"
		for((j=1;j<=column;j++))
		do
			if [ boardOfGame[$i,$j] == 0 ]
			then
				echo " X |"
			elif [ boardOfGame[$i,$j] == 1 ]
			then
				echo " O |"
			else
				#echo -n "   |"
				echo -n " + |"
				
			fi
		done
		echo  ""
	done
	echo ""
}
resettingBoard
assignedLetter
checkPlayer
displayGameBoard

