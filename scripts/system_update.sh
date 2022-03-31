# VARIABLES
# time
last_upgrade_date=$(grep "\[PACMAN\] starting full system upgrade" /var/log/pacman.log | tail -1 | grep -oP '\[\K[^\]]+' | head -1)
last_upgrade_time=$(date '+%s' -d "$last_upgrade_date")
current_time=$(date '+%s')
time_diff=$(($current_time-$last_upgrade_time))
day_diff=$(($time_diff/86400))
hour_diff=$((($time_diff-86400*$day_diff)/3600))
# colors
RED=`tput setaf 2`
BOLD=`tput bold`
NC=`tput sgr0`
# aux
trizen=0

# PROCESS
# Print last upgrade
if (( $day_diff > 6 )); then
	echo -e "${RED}You have not upgraded your system for ${day_diff} days ${hour_diff} hours!${NC}"
else
	echo "System last upgraded ${day_diff} days ${hour_diff} hours ago."
fi
# Trizen upgrade
while [ $trizen -le 0 ]; do
	echo -n "${BOLD}Do you wish to update using trizen? [Y/N]${NC} "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ];then 
		trizen -Syu
		exit
	elif [ "$answer" != "${answer#[Nn]}" ]; then
		trizen=1
	fi
done
# Pacman upgrade
while true; do
	echo -n "${BOLD}Do you wish to update? [Y/N]${NC} "
	read answer
	if [ "$answer" != "${answer#[Yy]}" ];then
		sudo pacman -Syu
		exit
	elif [ "$answer" != "${answer#[Nn]}" ];then
		exit
	fi
done