#!/bin/bash
#function for Firewall
Check_Firewall() {
	#Checking if Uncomplicated Firewall is installed
	if  command -v ufw >/dev/null 2>&1; then
		status=$(sudo ufw status | head -n 1)
		if [[ "$status" == "active" ]]; then
			echo "[Pass] Firewall is Active"
		else
			echo "[Warning] Firewall is Inactive"
		fi
		#Cheching if Firewalld is installed
	elif command -v firewall-cmd >/dev/null 2>&1; then
			status=$(firewall-cmd --state 2>/dev/null)
			if [[ "$status" == "running" ]]; then
				echo "[Pass] Firewall is Active"
			else
				echo "[Warning] Firewall is Inactive"
			fi
		else
			echo "[Warning] No supported Firewall tool found."
	fi
}
#funcction to check Root Account
Check_root(){
	if !command -v passwd >/dev/null 2>&1; then
		echo "[Error] Passwd command not found."
		return
	fi
	root_status=$(sudo passwd -S root)
	status=$(echo "$root_status" | awk '{print $2}')
	if [[ "$status" == "L" ]]; then
		echo "[Pass] Root account is Locked"
	elif [[ "$status" == "P" ]];then
		echo "[Warning] Root account has a password"
	else
		echo "[Info] Root account status:$root_status"
	fi
}

#function for checking file permission
File_Permission(){
	files=( "/etc/passwd"
		"/etc/shadow"
		"/etc/group"
		"try.txt"
	)
	for file in "${files[@]}"; do
		if [[ -e "$file" ]]; then
			permission=$(stat -c "%A" $file) 
			echo "File: $file"
			echo " Permission: $permission"

		#checkeing if file is writable by everyone
		if [[ "$(stat -c "%a" "$file")" =~ [1357]$  ]]; then
			echo "[Warning] Check the file write permission"
		else
			echo "[Pass] No world-write permission deteched"
		fi
		else
			echo "[Error] $file does not exist"
		fi
	done
}
#functio for checking secure shell service
Check_ssh(){
	#checking wheather systemctl exists
	if ! command -v systemctl; then 
		echo "[Error] systemctl command not found"
		return
	fi
	#checking for ssh service
	if systemctl list-unit-files | grep -q "^ssh.service" ; then
		if systemctl is-active --quiet ssh; then 
			echo "[Warning] SSH service is Running"
		else
			echo "[Pass] SSH service is NOT Running"
		fi
	elif systemctl list-unit-files | grep -q "^sshd.service" ; then
		if systemctl is-active --quiet sshd; then
			echo "[Warning] SSHD service is Running"
		else
			echo "[Pass] SSHD service is NOT Running"
		fi
	else
		echo "[Info] SSH service not found"
	fi
}

#function to run all security checks
all(){
	echo "==Running All Security Checks=="
	echo
	Check_Firewall
	echo
	Check_root
	echo
	File_Permission
	echo
	Check_ssh
	echo
	echo "Security Checks Done"
}
#function for help
Show_help() {
	echo "Usage: ./Task.sh 
	[Option]"
	echo
	echo "Options"	
	echo "--firewall	Check firewall Status"
	echo "--root		Check root account"
	echo "--permission	Check file permission"
	echo "--ssh		Check SSH service status"
	echo " --a	Perform all Security Checks"
	echo " --help	Display help menu"

}
if [[ "$1" == "--firewall" ]]; then
	Check_Firewall
	exit 0

elif [[ "$1" == "--root" ]]; then

	Check_root
	exit 0

elif [[ "$1" == "--permission" ]]; then
	File_Permission
	exit 0

elif [[ "$1" == "--ssh" ]]; then
	Check_ssh
	exit 0

elif [[ "$1" == "--all" ]]; then
	all
	exit 0

elif [[ "$1" == "--help" ]]; then
	Show_help
	exit 0

else
	echo "Type --help for Help"
	

fi
