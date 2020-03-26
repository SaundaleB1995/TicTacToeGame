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


	function playGame() {
	    while [[ $count -lt 9 ]]
	    do
		 if [ $flag == 0 ]
		 then
			echo "Player Play"
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
				     checkFlag=0
					echo "Computer Play"

                             if [ $checkFlag -eq 0 ]
            		     then
				computerWinning $computer $computer
            		     fi
            		if [ $checkFlag -eq 0 ]
            		then
               			computerWinning $player $computer
            		fi

                       if [ $checkFlag -eq 0 ]
           	 then 
                	 availableCorner
            	fi
             		if [ $checkFlag -eq 0 ]
            		then
                   		checkCenter
            		fi

			if [ $checkFlag -eq 0 ]
            		then
                   		takingSide
            		fi
				checkWin $computer
				((count++))
				flag=0
				fi
				done
			}
		tieCount=0
	function checkWin() {
		((tieCount++))
		letter=$1
		displayGameBoard
		winAtRowAndColumnPosition	$letter
		winAtDia $letter
		if [ $tieCount -gt 8 ]
		then
			echo "It's  a Tie"
			exit
		fi
		}

	function computerWinChecking() {
	         local m=$1
		local n=$2
		letter=$3
		if [[ ${game_Board[$m,$n]} == $letter ]]
		then
		      ((checkCount++))
		elif [[ ${game_Board[$m,$n]} == $"-" ]]
		then
		    ((newLetterCount++))
			row=$m
			column=$n
		fi
 		}

	function computerWinning() {
	         checkLetter=$1
		putLetter=$2
		checkFlag=0
		checkFlag1=0

   	        if [ $checkFlag1 -eq 0 ]
		then
		    for((i=0;i<3;i++))
		    do
			checkCount=0
			newLetterCount=0
			for((j=0;j<3;j++))
			do
				computerWinChecking $i $j $checkLetter
			done
		if [[ $checkCount -eq 2 && $newLetterCount -eq 1 ]]
		then
			game_Board[$row,$column]=$putLetter
			checkFlag1=1
			checkFlag=1
		fi
	done
	fi

		if [ $checkFlag1 -eq 0 ]
		then
			for((i=0;i<3;i++))
			do
				checkCount=0
				newLetterCount=0
			for((j=0;j<3;j++))
			do
				computerWinChecking $j $i $checkLetter
			done
			     if [[ $checkCount -eq 2 && $newLetterCount -eq 1 ]]
			     then
				game_Board[$row,$column]=$putLetter
				checkFlag1=1
				checkFlag=1
			     fi
		 done
	fi


	if [ $checkFlag1 -eq 0 ]
	then
		checkCount=0
		newLetterCount=0
		for((i=0;i<3;i++))
		do
			for((j=0;j<3;j++))
			do
				if [ $i -eq $j ]
				then
					computerWinChecking $i $j $checkLetter
				fi
			done
		done
		if [ $checkCount -eq 2 -a $newLetterCount -eq 1 ]
		then
			game_Board[$row,$column]=$putLetter
			checkFlag1=1
			checkFlag=1
		fi
	fi


	if [ $checkFlag1 -eq 0 ]
	then
		checkCount=0
		newLetterCount=0
		for((i=0;i<3;i++))
		do
			for((j=$((2-$i));j<3;j++))
			do
				computerWinChecking $i $j $checkLetter
				break
			done
		done
		if [[ $checkCount -eq 2 && $newLetterCount -eq 1 ]]
		then
			game_Board[$row,$column]=$putLetter
			checkFlag1=1
			checkFlag=1
		fi
	fi
}

function availableCorner(){
	checkFlag=0
	local putLetter=$1
	for((i=0;i<rows;i=$(($i+2))))
	do
		for((j=0;j<columns;j=$(($j+2))))
		do
			if [[ ${game_Board[$i,$j]} == "-" ]]
			then
				game_Board[$i,$j]=$putLetter
				checkFlag=1
				return
			fi
		done
	done
}

function checkCenter() {
	checkFlag=0
	if [[ ${game_Board[1,1]} == $"-" ]]
	then
		game_Board[1,1]=$computer
	else
		checkFlag=1
	fi
}

function takingSide() {
	for((i=0; i<$rows; i++))
	do
		for((j=1; j<$columns; j++))
		do
			if [[ ${game_Board[$i,$j]} == "-" ]]
			then
				game_Board[$i,$j]=$computer
				checkFlag=1
			fi
		done
		if [[ $checkFlag -eq 1 ]]
		then
			break
		fi
	done
}
function playerOrComputerWon() {
	local Letter=$1
	if [[ $Letter == $player ]]
	then
		echo "Player Won"
	else
		echo "Computer Won"
	fi
	exit
}

function winAtRowAndColumnPosition() {
	letter=$1
	for((r=0;r<$rows;r++))
	do
		for((c=0;c<$columns;c++))
		do
			if [[ ${game_Board[$r,$c]} == ${game_Board[$r,$(($c+1))]} ]] && [[ ${game_Board[$r,$(($c+1))]} == ${game_Board[$r,$(($c+2))]} ]] && [[ ${game_Board[$r,$c]} == $letter ]]
			then
				playerOrComputerWon $letter
			elif [[ ${game_Board[$r,$c]} == ${game_Board[$(($r+1)),$c]} ]] && [[ ${game_Board[$(($r+1)),$c]} == ${game_Board[$(($r+2)),$c]} ]] && [[ ${game_Board[$r,$c]} == $letter ]]
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


playGame
