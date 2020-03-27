#!/bin/bash 
echo "Welcome To Tic Tac Toe Game."

rows=3
columns=3
player=0
total_Move=$(($rows*$columns))
count=0
tieCount=0

declare -A game_Board
function resettingBoard() {
	for((i=0; i<$rows; i++))
	do
		for((j=0; j<$columns; j++))
		do
			game_Board[$i,$j]="-"
		done
	done
}
function assignedLetters() {
	if [ $((RANDOM%3)) -eq 1 ]
	then
		player="X"
		computer="O"
	else
		player="O"
		computer="X"
	fi
	echo "Assigned Player letter: " $player
	echo "Assigned Computer letter: " $computer
}
function checkFirstPlay() {
	if [[ $((RANDOM%3)) -eq $player ]]
	then
		flag=0
		echo "Player Play First"
	else
		flag=1
		echo "Computer Play First"
	fi
}
function displayGameBoard() {
	echo ""
	for((i=0; i<$rows; i++))
	do
		for((j=0; j<$columns; j++))
		do
			echo -n " ${game_Board[$i,$j]} |"
		done
		echo
		echo ""
	done
}
function PlayerTurn(){
	if [ $flag == 0 ]
	then
		echo "Player Play"
		read -p "Enter Player Row " row
		read -p "Enter Player Col " column
		if [[ $row -ge 0 && $row -le 2 && $column -ge 0 && $column -le 2 ]]
		then
			if [[ ${game_Board[$row,$column]} != $player && ${game_Board[$row,$column]} != $computer ]]
			then
				game_Board[$row,$column]=$player
				checkWin $player
				((count++))
				flag=1
			else
				echo "Cell Is Not Empty"
			fi
		else
			echo "Invalid"
		fi
	fi
}
function ComputerTurn() {
	if [ $flag == 1 ]
	then
		checkFlag=0
		echo "Computer Play"
		if [ $checkFlag -eq 0 ]
		then
			computerWinningBoard $computer
		fi
		if [ $checkFlag -eq 0 ]
		then
			computerWinningBoard $player
		fi
		if [ $checkFlag -eq 0 ]
		then
			takingCorner
		fi
		if [ $checkFlag -eq 0 ]
		then
			takingCenter
		fi
		if [ $checkFlag -eq 0 ]
		then
			takingSide
		fi
		checkWin $computer
		((count++))
		flag=0
	fi
}
function playGame() {
	while [[ $count -lt $total_Move ]]
	do
		PlayerTurn
		ComputerTurn
	done
}
function checkWin() {
	((tieCount++))
	letter=$1
	displayGameBoard
	winAtRowAndColumnPosition $letter
	winAtDia $letter
	if [ $tieCount -gt 8 ]
	then
		echo "It's a Tie"
		exit
	fi
}
function computerWinChecking() {
	local x=$1
	local y=$2
	letter=$3
	if [[ ${game_Board[$x,$y]} == $letter ]]
	then
		((checkCount++))
	fi
	if [[ ${game_Board[$x,$y]} == "-" ]]
	then
		((newLetterCount++))
		row=$x
		column=$y
	fi
}
function reassignCounter() {
		checkCount=0
		newLetterCount=0
}
function checkCounterAndChangeFlagValue() {
	local rowValue=$1
	local columnValue=$2
	if [[ $checkCount -eq 2 && $newLetterCount -eq 1 ]]
	then
		game_Board[$rowValue,$columnValue]=$computer
		checkFlag1=1
		checkFlag=1
		checkColumnFlag=0
	fi
}
function winAndBlockRowAndColumn() {
	for((i=0; i<$rows; i++))
	do
		reassignCounter
		for((j=0; j<$columns; j++))
		do
			if [ $checkColumnFlag -eq 1 ]
			then
				computerWinChecking $j $i $checkLetter
			else
				computerWinChecking $i $j $checkLetter
			fi
		done
		checkCounterAndChangeFlagValue $rows $columns
	done
}
function computerWinningBoard() {
	checkLetter=$1
	checkColumnFlag=0
	checkFlag=0
	checkFlag1=0
	if [ $checkFlag1 -eq 0 ]
	then
		checkColumnFlag=0
		winAndBlockRowAndColumn
	fi
	if [ $checkFlag1 -eq 0 ]
	then
		checkColumnFlag=1
		winAndBlockRowAndColumn
	fi
	if [ $checkFlag1 -eq 0 ]
	then
		reassignCounter
		for((i=0; i<$rows; i++))
		do
			for((j=0; j<$columns; j++))
			do
				if [ $i -eq $j ]
				then
					computerWinChecking $i $j $checkLetter
				fi
			done
		done
		checkCounterAndChangeFlagValue $rows $columns
	fi
	if [ $checkFlag1 -eq 0 ]
	then
		reassignCounter
		for((i=0; i<$rows; i++))
		do
			for((j=$((2-$i)); j<$columns; j++))
			do
				computerWinChecking $i $j $checkLetter
				break
			done
		done
		checkCounterAndChangeFlagValue $rows $columns
	fi
}
function takingCorner(){
	for((i=0; i<$rows; i=$(($i+2))))
	do
		for((j=0; j<$columns; j=$(($j+2))))
		do
			if [[ ${game_Board[$i,$j]} == "-" ]]
			then
				game_Board[$i,$j]=$computer
				checkFlag=1
				return
			fi
		done
	done
}
function takingCenter() {
	if [[ ${game_Board[$(($rows/2)),$(($columns/2))]} == "-" ]]
	then
		game_Board[$(($rows/2)),$(($columns/2))]=$computer
		checkFlag=1
	fi
}
function takingSide() {
	for((i=0; i<$rows; i++))
	do
		for((j=1; j<$columns; j++))
		do
			if [ ${game_Board[$i,$j]} == "-" ]
			then
				game_Board[$i,$j]=$computer
				checkFlag=1
			fi
		done
		if [ $checkFlag -eq 1 ]
		then
			break
		fi
	done
}
function playerOrComputerWon() {
	local letter=$1
	if [[ $letter == $player ]]
	then
		echo "Player Won"
	else
		echo "Computer Won"
	fi
	exit
}
function winAtRowAndColumnPosition() {
	letter=$1
	for((i=0; i<$rows; i++))
	do
		for((j=0; j<$columns; j++))
		do
			if [[ ${game_Board[$i,$j]} == ${game_Board[$i,$(($j+1))]} ]] && [[ ${game_Board[$i,$(($j+1))]} == ${game_Board[$i,$(($j+2))]} ]] && [[ ${game_Board[$i,$j]} == $letter ]]
			then
				playerOrComputerWon $letter
			elif [[ ${game_Board[$i,$j]} == ${game_Board[$(($i+1)),$j]} ]] && [[ ${game_Board[$(($i+1)),$j]} == ${game_Board[$(($i+2)),$j]} ]] && [[ ${game_Board[$i,$j]} == $letter ]]
			then
				playerOrComputerWon $letter
			fi
		done
	done
}
function winAtDia() {
	letter=$1
	if [[ ${game_Board[0,0]} == ${game_Board[1,1]} ]] && [[ ${game_Board[1,1]} == ${game_Board[2,2]} ]] && [[ ${game_Board[0,0]} == $letter ]]
	then
		playerOrComputerWon $letter
	elif [[ ${game_Board[0,2]} == ${game_Board[1,1]} ]] && [[ ${game_Board[1,1]} == ${game_Board[2,0]} ]] && [[ ${game_Board[0,2]} == $letter ]]
	then
		playerOrComputerWon $letter
	fi
}
resettingBoard
assignedLetters
checkFirstPlay
displayGameBoard
playGame
