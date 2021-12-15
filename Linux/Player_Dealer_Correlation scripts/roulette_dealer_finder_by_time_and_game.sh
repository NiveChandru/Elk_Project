#!/bin/bash
case "$4" in
	#case 1
	"blackjack") awk -F" " '{print $1,$2,$3,$4}' ~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/$1_Dealer_schedule | grep "$2:00:00 $3";;
	#case 2
	"roulette")  awk -F" " '{print $1,$2,$5,$6}' ~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/$1_Dealer_schedule | grep "$2:00:00 $3";;
	#case 3
	"texashold") awk -F" " '{print $1,$2,$7,$8}' ~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/$1_Dealer_schedule | grep "$2:00:00 $3";;
esac
