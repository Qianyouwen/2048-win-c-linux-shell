#!/bin/bash
rm -f temp
clear

function testing()
{
	rm -f dir
	for((i=1;i<5;i++))
	do
		I=`expr $i \* 2 - 1`
		value1=`sed -n ${I}p temp|cut -f1`
		value2=`sed -n ${I}p temp|cut -f2`
		value3=`sed -n ${I}p temp|cut -f3`
		value4=`sed -n ${I}p temp|cut -f4`
		value5=`sed -n 1p temp|cut -f${i}`
		value6=`sed -n 3p temp|cut -f${i}`
		value7=`sed -n 5p temp|cut -f${i}`
		value8=`sed -n 7p temp|cut -f${i}`
		if [ $value1 -gt 0 ]
		then
			if [ $value2 -eq 0 -o $value3 -eq 0 -o $value4 -eq 0 -o $value1 -eq $value2 ]
			then
				echo right >> dir
			fi
		fi
		if [ $value2 -gt 0 ]
		then
			if [ $value1 -eq 0 -o $value1 -eq $value2 ]
			then
				echo left >> dir
			fi
			if [ $value3 -eq 0 -o $value4 -eq 0 -o $value2 -eq $value3 ]
			then
				echo right >> dir
			fi
		fi
		if [ $value3 -gt 0 ]
		then
			if [ $value1 -eq 0 -o $value2 -eq 0 -o $value2 -eq $value3 ]
			then
				echo left >> dir
			fi
			if [ $value4 -eq 0 -o $value3 -eq $value4 ]
			then
				echo right >> dir
			fi
		fi
		if [ $value4 -gt 0 ]
		then
			if [ $value1 -eq 0 -o $value2 -eq 0 -o $value3 -eq 0 -o $value3 -eq $value4 ]
			then
				echo left >> dir
			fi
		fi
		if [ $value5 -gt 0 ]
		then
			if [ $value6 -eq 0 -o $value7 -eq 0 -o $value8 -eq 0 -o $value5 -eq $value6 ]
			then
				echo down >> dir
			fi
		fi
		if [ $value6 -gt 0 ]
		then
			if [ $value5 -eq 0 -o $value5 -eq $value6 ]
			then
				echo up >> dir
			fi
			if [ $value7 -eq 0 -o $value8 -eq 0 -o $value6 -eq $value7 ]
			then
				echo down >> dir
			fi
		fi
		if [ $value7 -gt 0 ]
		then
			if [ $value5 -eq 0 -o $value6 -eq 0 -o $value6 -eq $value7 ]
			then
				echo up >> dir
			fi
			if [ $value8 -eq 0 -o $value7 -eq $value8 ]
			then
				echo down >> dir
			fi
		fi
		if [ $value8 -gt 0 ]
		then
			if [ $value5 -eq 0 -o $value6 -eq 0 -o $value7 -eq 0 -o $value7 -eq $value8 ]
			then
				echo up >> dir
			fi
		fi
	done
}
function modify()
{
	arg0=`expr $1 \* 2 - 1`
	arg1=`expr $1 \* 2 - 2`
	arg2=`expr $2 - 1`
	arg=`expr $1 \* 2`
	arg3=`expr 8 - $arg`
	arg4=`expr $2 + 1`
	head -$arg1 temp > temp1
	if [ $arg2 -gt 0 ]
	then
		sed -n ${arg0}p temp|cut -f1-$arg2 > temp2
	fi
	if [ $arg4 -lt 5 ]
	then
		sed -n ${arg0}p temp|cut -f$arg4-4 > temp3
	fi
	echo $3 > temp4
	if [ $arg2 -gt 0 ]
	then
		if [ $arg4 -lt 5 ]
		then
			paste temp2 temp4 temp3 >> temp1
		else
			paste temp2 temp4 >> temp1
		fi
	else
		if [ $arg4 -lt 5 ]
		then
			paste temp4 temp3 >> temp1
		else
			cat temp4 >> temp1
		fi
	fi
	tail -$arg3 temp >> temp1
	mv temp1 temp
	rm -f temp2 temp3 temp4
		
}
function uuu()
{
	TTT=0
	rm -f X_Y
	for((i=1;i<5;i++))
	do
		ttt=0
		value1=`sed -n 1p temp|cut -f${i}`
		value2=`sed -n 3p temp|cut -f${i}`
		value3=`sed -n 5p temp|cut -f${i}`
		value4=`sed -n 7p temp|cut -f${i}`
		if [ $value1 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
		fi
		if [ $value2 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value1 -eq 0 ]
			then
				modify 1 $i $value2
				modify 2 $i 0
			else
				if [ $value1 -eq $value2 ]
				then
					M=`expr $value1 \* 2`
					modify 1 $i $M
					modify 2 $i 0
					ttt=`expr $ttt - 1`
				fi
			fi
		fi
		value1=`sed -n 1p temp|cut -f${i}`
		value2=`sed -n 3p temp|cut -f${i}`
		value3=`sed -n 5p temp|cut -f${i}`
		value4=`sed -n 7p temp|cut -f${i}`
		if [ $value3 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value2 -eq $value3 ]
			then
				M=`expr $value2 \* 2`
				modify 2 $i $M
				modify 3 $i 0
				ttt=`expr $ttt - 1`
			elif [ $value2 -eq 0 ]
			then
				if [ $value1 -eq 0 ]
				then
					modify 1 $i $value3
					modify 3 $i 0
				elif [ $value1 -eq $value3 ]
				then
					M=`expr $value1 \* 2`
					modify 1 $i $M
					modify 3 $i 0
					ttt=`expr $ttt - 1`
				else
					modify 2 $i $value3
					modify 3 $i 0
				fi
			fi
		fi
		value1=`sed -n 1p temp|cut -f${i}`
		value2=`sed -n 3p temp|cut -f${i}`
		value3=`sed -n 5p temp|cut -f${i}`
		value4=`sed -n 7p temp|cut -f${i}`
		if [ $value4 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value3 -eq $value4 ]
			then
				M=`expr $value3 \* 2`
				modify 3 $i $M
				modify 4 $i 0
				ttt=`expr $ttt - 1`
			elif [ $value3 -eq 0 ]
			then
				if [ $value2 -eq 0 ]
				then
					if [ $value1 -eq 0 ]
					then
						modify 1 $i $value4
						modify 4 $i 0
					elif [ $value1 -eq $value4 ]
					then
						M=`expr $value1 \* 2`
						modify 1 $i $M
						modify 4 $i 0
						ttt=`expr $ttt - 1`
					else
						modify 2 $i $value4
						modify 4 $i 0
					fi
				elif [ $value2 -eq $value4 ]
				then
					M=`expr $value2 \* 2`
					modify 2 $i $M
					modify 4 $i 0
					ttt=`expr $ttt - 1`
				else
					modify 3 $i $value4
					modify 4 $i 0
				fi
			fi
		fi
		TTT=`expr $TTT + 4 - $ttt`
		while [ $ttt -lt 4 ]
		do
			X=`expr $ttt + 1`
			Y=$i
			echo -e "$X\t$Y" >> X_Y
			ttt=`expr $ttt + 1`
		done
	done
	seed=`date +%s`
	ram=`expr $seed % $TTT + 1`
	x=`sed -n ${ram}p X_Y|awk '{print $1}'`
	y=`sed -n ${ram}p X_Y|awk '{print $2}'`
	modify $x $y 2
}

function ddd()
{
	TTT=0
	rm -f X_Y
	for((i=1;i<5;i++))
	do
		ttt=0
		value1=`sed -n 1p temp|cut -f${i}`
		value2=`sed -n 3p temp|cut -f${i}`
		value3=`sed -n 5p temp|cut -f${i}`
		value4=`sed -n 7p temp|cut -f${i}`
		if [ $value4 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
		fi
		if [ $value3 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value4 -eq 0 ]
			then
				modify 4 $i $value3
				modify 3 $i 0
			else
				if [ $value3 -eq $value4 ]
				then
					M=`expr $value4 \* 2`
					modify 4 $i $M
					modify 3 $i 0
					ttt=`expr $ttt - 1`
				fi
			fi
		fi
		value1=`sed -n 1p temp|cut -f${i}`
		value2=`sed -n 3p temp|cut -f${i}`
		value3=`sed -n 5p temp|cut -f${i}`
		value4=`sed -n 7p temp|cut -f${i}`
		if [ $value2 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value2 -eq $value3 ]
			then
				M=`expr $value2 \* 2`
				modify 3 $i $M
				modify 2 $i 0
				ttt=`expr $ttt - 1`
			elif [ $value3 -eq 0 ]
			then
				if [ $value4 -eq 0 ]
				then
					modify 4 $i $value2
					modify 2 $i 0
				elif [ $value4 -eq $value2 ]
				then
					M=`expr $value4 \* 2`
					modify 4 $i $M
					modify 2 $i 0
					ttt=`expr $ttt - 1`
				else
					modify 3 $i $value2
					modify 2 $i 0
				fi
			fi
		fi
		value1=`sed -n 1p temp|cut -f${i}`
		value2=`sed -n 3p temp|cut -f${i}`
		value3=`sed -n 5p temp|cut -f${i}`
		value4=`sed -n 7p temp|cut -f${i}`
		if [ $value1 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value1 -eq $value2 ]
			then
				M=`expr $value2 \* 2`
				modify 2 $i $M
				modify 1 $i 0
				ttt=`expr $ttt - 1`
			elif [ $value2 -eq 0 ]
			then
				if [ $value3 -eq 0 ]
				then
					if [ $value4 -eq 0 ]
					then
						modify 4 $i $value1
						modify 1 $i 0
					elif [ $value4 -eq $value1 ]
					then
						M=`expr $value4 \* 2`
						modify 4 $i $M
						modify 1 $i 0
						ttt=`expr $ttt - 1`
					else
						modify 3 $i $value1
						modify 1 $i 0
					fi
				elif [ $value3 -eq $value1 ]
				then
					M=`expr $value1 \* 2`
					modify 3 $i $M
					modify 1 $i 0
					ttt=`expr $ttt - 1`
				else
					modify 2 $i $value1
					modify 1 $i 0
				fi
			fi
		fi
		TTT=`expr $TTT + 4 - $ttt`
		while [ $ttt -lt 4 ]
		do
			X=`expr 4 - $ttt`
			Y=$i
			echo -e "$X\t$Y" >> X_Y
			ttt=`expr $ttt + 1`
		done
	done
	seed=`date +%s`
	ram=`expr $seed % $TTT + 1`
	x=`sed -n ${ram}p X_Y|awk '{print $1}'`
	y=`sed -n ${ram}p X_Y|awk '{print $2}'`
	modify $x $y 2
}

function lll()
{
	TTT=0
	rm -f X_Y
	for((i=1;i<5;i++))
	do
		ttt=0
		I=`expr $i \* 2 - 1`
		value1=`sed -n ${I}p temp|cut -f1`
		value2=`sed -n ${I}p temp|cut -f2`
		value3=`sed -n ${I}p temp|cut -f3`
		value4=`sed -n ${I}p temp|cut -f4`
		if [ $value1 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
		fi
		if [ $value2 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value1 -eq 0 ]
			then
				modify $i 1 $value2
				modify $i 2 0
			else
				if [ $value1 -eq $value2 ]
				then
					M=`expr $value1 \* 2`
					modify $i 1 $M
					modify $i 2 0
					ttt=`expr $ttt - 1`
				fi
			fi
		fi
		value1=`sed -n ${I}p temp|cut -f1`
		value2=`sed -n ${I}p temp|cut -f2`
		value3=`sed -n ${I}p temp|cut -f3`
		value4=`sed -n ${I}p temp|cut -f4`
		if [ $value3 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value2 -eq $value3 ]
			then
				M=`expr $value2 \* 2`
				modify $i 2 $M
				modify $i 3 0
				ttt=`expr $ttt - 1`
			elif [ $value2 -eq 0 ]
			then
				if [ $value1 -eq 0 ]
				then
					modify $i 1 $value3
					modify $i 3 0
				elif [ $value1 -eq $value3 ]
				then
					M=`expr $value1 \* 2`
					modify $i 1 $M
					modify $i 3 0
					ttt=`expr $ttt - 1`
				else
					modify $i 2 $value3
					modify $i 3 0
				fi
			fi
		fi
		value1=`sed -n ${I}p temp|cut -f1`
		value2=`sed -n ${I}p temp|cut -f2`
		value3=`sed -n ${I}p temp|cut -f3`
		value4=`sed -n ${I}p temp|cut -f4`
		if [ $value4 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value3 -eq $value4 ]
			then
				M=`expr $value3 \* 2`
				modify $i 3 $M
				modify $i 4 0
				ttt=`expr $ttt - 1`
			elif [ $value3 -eq 0 ]
			then
				if [ $value2 -eq 0 ]
				then
					if [ $value1 -eq 0 ]
					then
						modify $i 1 $value4
						modify $i 4 0
					elif [ $value1 -eq $value4 ]
					then
						M=`expr $value1 \* 2`
						modify $i 1 $M
						modify $i 4 0
						ttt=`expr $ttt - 1`
					else
						modify $i 2 $value4
						modify $i 4 0
					fi
				elif [ $value2 -eq $value4 ]
				then
					M=`expr $value2 \* 2`
					modify $i 2 $M
					modify $i 4 0
					ttt=`expr $ttt - 1`
				else
					modify $i 3 $value4
					modify $i 4 0
				fi
			fi
		fi
		TTT=`expr $TTT + 4 - $ttt`
		while [ $ttt -lt 4 ]
		do
			X=$i
			Y=`expr $ttt + 1`
			echo -e "$X\t$Y" >> X_Y
			ttt=`expr $ttt + 1`
		done
	done
	cat temp
	seed=`date +%s`
	ram=`expr $seed % $TTT + 1`
	x=`sed -n ${ram}p X_Y|awk '{print $1}'`
	y=`sed -n ${ram}p X_Y|awk '{print $2}'`
	modify $x $y 2
}

function rrr()
{
	TTT=0
	rm -f X_Y
	for((i=1;i<5;i++))
	do
		ttt=0
		I=`expr $i \* 2 - 1`
		value1=`sed -n ${I}p temp|cut -f1`
		value2=`sed -n ${I}p temp|cut -f2`
		value3=`sed -n ${I}p temp|cut -f3`
		value4=`sed -n ${I}p temp|cut -f4`
		if [ $value4 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
		fi
		if [ $value3 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value4 -eq 0 ]
			then
				modify $i 4 $value3
				modify $i 3 0
			else
				if [ $value3 -eq $value4 ]
				then
					M=`expr $value4 \* 2`
					modify $i 4 $M
					modify $i 3 0
					ttt=`expr $ttt - 1`
				fi
			fi
		fi
		value1=`sed -n ${I}p temp|cut -f1`
		value2=`sed -n ${I}p temp|cut -f2`
		value3=`sed -n ${I}p temp|cut -f3`
		value4=`sed -n ${I}p temp|cut -f4`
		if [ $value2 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value2 -eq $value3 ]
			then
				M=`expr $value2 \* 2`
				modify $i 3 $M
				modify $i 2 0
				ttt=`expr $ttt - 1`
			elif [ $value3 -eq 0 ]
			then
				if [ $value4 -eq 0 ]
				then
					modify $i 4 $value2
					modify $i 2 0
				elif [ $value4 -eq $value2 ]
				then
					M=`expr $value4 \* 2`
					modify $i 4 $M
					modify $i 2 0
					ttt=`expr $ttt - 1`
				else
					modify $i 3 $value2
					modify $i 2 0
				fi
			fi
		fi
		value1=`sed -n ${I}p temp|cut -f1`
		value2=`sed -n ${I}p temp|cut -f2`
		value3=`sed -n ${I}p temp|cut -f3`
		value4=`sed -n ${I}p temp|cut -f4`
		if [ $value1 -gt 0 ]
		then
			ttt=`expr $ttt + 1`
			if [ $value1 -eq $value2 ]
			then
				M=`expr $value2 \* 2`
				modify $i 2 $M
				modify $i 1 0
				ttt=`expr $ttt - 1`
			elif [ $value2 -eq 0 ]
			then
				if [ $value3 -eq 0 ]
				then
					if [ $value4 -eq 0 ]
					then
						modify $i 4 $value1
						modify $i 1 0
					elif [ $value4 -eq $value1 ]
					then
						M=`expr $value4 \* 2`
						modify $i 4 $M
						modify $i 1 0
						ttt=`expr $ttt - 1`
					else
						modify $i 3 $value1
						modify $i 1 0
					fi
				elif [ $value3 -eq $value1 ]
				then
					M=`expr $value1 \* 2`
					modify $i 3 $M
					modify $i 1 0
					ttt=`expr $ttt - 1`
				else
					modify $i 2 $value1
					modify $i 1 0
				fi
			fi
		fi
		TTT=`expr $TTT + 4 - $ttt`
		while [ $ttt -lt 4 ]
		do
			X=$i
			Y=`expr 4 - $ttt`
			echo -e "$X\t$Y" >> X_Y
			ttt=`expr $ttt + 1`
		done
	done
	seed=`date +%s`
	ram=`expr $seed % $TTT + 1`
	x=`sed -n ${ram}p X_Y|awk '{print $1}'`
	y=`sed -n ${ram}p X_Y|awk '{print $2}'`
	modify $x $y 2
}

echo -e "0""\t""0""\t""0""\t""0" >> temp
echo "" 		         >> temp
echo -e "0""\t""0""\t""0""\t""0" >> temp
echo "" 		         >> temp
echo -e "0""\t""0""\t""0""\t""0" >> temp
echo "" 		         >> temp
echo -e "0""\t""0""\t""0""\t""0" >> temp

seed=`date +%s`
ram=`expr $seed % 16`
x=`expr $ram / 4 + 1`
y=`expr $ram % 4 + 1`
#echo $x $y
modify $x $y 2
cat temp
echo ""
echo -e "\nup\tw\ndown\ts\nleft\ta\nright\td\nquit\tq\n"
testing
flag=1
while [ $flag -eq 1 ]
do
	testing
	UP=`grep up dir|wc -l|awk '{print $1}'`
	DOWN=`grep down dir|wc -l|awk '{print $1}'`
	RIGHT=`grep right dir|wc -l|awk '{print $1}'`
	LEFT=`grep left dir|wc -l|awk '{print $1}'`
	read  choose
	if [ $choose == 'a' -a $LEFT -gt 0 ]
	then
		lll
		clear
		cat temp
		echo -e "\nup\tw\ndown\ts\nleft\ta\nright\td\nquit\tq\n"
	elif [ $choose == 'w' -a $UP -gt 0 ]
	then
		uuu
		clear
		cat temp
		echo -e "\nup\tw\ndown\ts\nleft\ta\nright\td\nquit\tq\n"
	elif [ $choose == 'd' -a $RIGHT -gt 0 ]
	then
		rrr
		clear
		cat temp
		echo -e "\nup\tw\ndown\ts\nleft\ta\nright\td\nquit\tq\n"
	elif [ $choose == 's' -a $DOWN -gt 0 ]
	then
		ddd
		clear
		cat temp
		echo -e "\nup\tw\ndown\ts\nleft\ta\nright\td\nquit\tq\n"
	elif [ $choose == 'q' ]
	then
		echo "BYE!SON!"
		break;
	else
		continue
	fi
done
rm -f temp X_Y dir

