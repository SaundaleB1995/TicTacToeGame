#!/bin/bash
     echo "Welcome to Tic Tac Toe Game"


#!/bin/bash
echo "Welcome To Tic Tac Toe Game"

rows=3
columns=3

declare -A game_Board
function resettingBoard() 
{
	for ((i=0; i<rows; i++))
	do
		for ((j=0; j<columns; j++))
		do
			game_Board[$i,$j]="-"
		done
	done
}
function assignletters() {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		Player="X"
		Computer="O"
	else
		Player="O"
		Computer="X"
	fi
	echo "Assigned Player Symbol: " $Player
	echo "Assigned Computer Symbol: " $Computer
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
			echo -n "| ${game_Board[$i,$j]} |"
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
		read -p "Enter Player Row " row
		read -p "Enter Player Col " col
		if [[ ${game_Board[$row,$col]} != $Player ]]
		then
			game_Board[$row,$col]=$Player
			displayGameBoard
			winAtRowPosition	$Player
			winAtColPosition $Player
			winAtDia $Player
			((count++))
		else
			echo "Invalid"
		fi
	done
}

function winAtRowPosition() 
{
	for((r=0;r<3;r++))
	do
		for((c=0;c<3;c++))
		do
			if [[ ${game_Board[$r,$c]} == ${game_Board[$r,$(($c+1))]} ]] && [[ ${game_Board[$r,$(($c+1))]} == ${game_Board[$r,$(($c+2))]} ]] && [[ ${game_Board[$r,$c]} == $1 ]]
			then
				echo $1 "Win"
				exit
			fi
		done
	done
}

function winAtColPosition() 
{
	for((r=0;r<3;r++))
	do
		for((c=0;c<3;c++))
		do
			if [[ ${game_Board[$r,$c]} == ${game_Board[$(($r+1)),$c]} ]] && [[ ${game_Board[$(($r+1)),$c]} == ${game_Board[$(($r+2)),$c]} ]] && [[ ${game_Board[$r,$c]} == $1 ]]
			then
				echo $1 "Win"
				exit
			fi
		done
	done
}

function winAtDia() 
{
	if [[ ${game_Board[0,0]} == ${game_Board[1,1]} ]] && [[ ${game_Board[1,1]} == ${game_Board[2,2]} ]] && [[ ${game_Board[0,0]} == $1 ]]
	then
		echo $1 "Win"
		exit
	elif [[ ${game_Board[0,2]} == ${game_Board[1,1]} ]] && [[ ${game_Board[1,1]} == ${game_Board[2,0]} ]] && [[ ${game_Board[0,2]} == $1 ]]
	then
		echo $1 "Win"
		exit
	fi
}

playGame





