#!/bin/bash/
awk -F" " '{print $1,$2,$5,$6}' ~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/0312_Dealer_schedule| grep "11:00:00" | grep "PM"
