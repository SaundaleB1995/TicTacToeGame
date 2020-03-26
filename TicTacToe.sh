#!/bin/bash
     echo "Welcome to Tic Tac Toe Game"


rows=3
columns=3

declare -A game_Board
function resettingBoard() 
{
	for ((i=0; i<$rows; i++))
	do
		for ((j=0; j<$columns; j++))
		do
			game_Board[$i,$j]="-"
		done
	done
}

function assignletters() {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		player="X"
		computer="O"
	else
		player="O"
		computer="X"
	fi
	echo "Assigned Player Symbol: " $player
	echo "Assigned Computer Symbol: " $computer
}

resettingBoard
assignletters

function checkFirstPlay() {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		flag=0
		echo "Player Play First"
	else
		flag=1
		echo "Computer Play First"
	fi
}
checkFirstPlay

function displayGameBoard()
{
	echo ""
	for((i=0;i<rows;i++))
	do
		for((j=0;j<columns;j++))
		do
			echo -n " ${game_Board[$i,$j]} |"
		done
		echo
		echo ""
	done
}
displayGameBoard
count=0
function playGame() 
{
	while [[ $count -lt 9 ]]
	do
	   if [[ $flag == 0 ]]
       then
           echo "Player Turn"
		read -p "Enter Row " row
		read -p "Enter Col " col
        if [[ $row -ge $rows && $col -ge $columns ]]
		then
               echo "Invalid"
		elif [[ ${game_Board[$row,$col]} != $player ]]
		then
			game_Board[$row,$col]=$player
            checkWin $player
				((count++))
				flag=1
			else
				echo "Cell Is Not Empty"
			fi
        elif [ $flag == 1 ]
        then
          echo "Computer turn"
			row=$((RANDOM%3))
			col=$((RANDOM%3))
			if [[ ${game_Board[$row,$col]} != $player && ${game_Board[$row,$col]} != $computer ]]
			then
				game_Board[$row,$col]=$computer
				checkWin $computer
				flag=0
				((count++))
			fi
		fi
	done
}
      function checkWin() {
          letter=$1
			displayGameBoard
			winAtRowPosition $1
			winAtColPosition $1
			winAtDia $1
			
}

function winAtRowPosition() 
{
    letter=$1
	for((i=0;i<$rows;i++))
	do
		for((j=0;j<$columns;j++))
		do
			if [[ ${game_Board[$i,$j]} == ${game_Board[$i,$(($j+1))]} ]] && [[ ${game_Board[$i,$(($j+1))]} == ${game_Board[$i,$(($j+2))]} ]] && [[ ${game_Board[$i,$j]} == $letter ]]
			then
				echo $letter "Win"
				exit
			fi
		done
	done
}

function winAtColPosition() 
{   letter=$1
	for((i=0;i<3;i++))
	do
		for((j=0;j<3;j++))
		do
			if [[ ${game_Board[$i,$j]} == ${game_Board[$(($i+1)),$j]} ]] && [[ ${game_Board[$(($i+1)),$c]} == ${game_Board[$(($r+2)),$c]} ]] && [[ ${game_Board[$r,$j]} == $letter ]]
			then
				echo $letter "Win"
				exit
			fi
		done
	done
}

function winAtDia() 
{    letter=$1
	if [[ ${game_Board[0,0]} == ${game_Board[1,1]} ]] && [[ ${game_Board[1,1]} == ${game_Board[2,2]} ]] && [[ ${game_Board[0,0]} == $letter ]]
	then
		echo $letter "Win"
		exit
	elif [[ ${game_Board[0,2]} == ${game_Board[1,1]} ]] && [[ ${game_Board[1,1]} == ${game_Board[2,0]} ]] && [[ ${game_Board[0,2]} == $letter ]]
	  then
		echo $letter "Win"
		exit
	fi
}
playGame


