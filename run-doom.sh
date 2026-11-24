#!/bin/bash
echo -e "\x1b[1;31m=== Running Doom Sh(ell) ===\x1b[0m"

# Load Config
source "$(dirname "$0")/config.env"

# Given a list, prompt user to select an option
# Automatically handles cases of a single item in an array
select_option() {
	local option_array=("$@")

	if [ "${#option_array[@]}" -eq 1 ]; then
		echo $option_array
		return 0
	fi

	select opt in "${option_array[@]}"; do
		for entry in "${option_array[@]}"; do
			entry_name="${entry%%|*}"
			opt_name="${opt%%|*}"
			if [ "$entry_name" = "$opt_name" ]; then
				option_path="${entry##*|}"
				echo "$option_path"
				break 2
			fi
		done
	done

}

# Select GZDoom Version
if [ "${#GZDOOM_PATH[@]}" -gt 1 ]; then
	echo -e "\x1b[1;31m! Multiple GZDoom versions loaded. Select a GZDoom version:\x1b[0m"
fi
doom_path=$(select_option "${GZDOOM_PATH[@]}")

# Select IWAD
if [ "${#IWAD_PATH[@]}" -gt 1 ]; then
	echo -e "\x1b[1;31m! Multiple IWADs versions loaded. Select an IWAD:\x1b[0m"
fi
wad_path=$(select_option "${IWAD_PATH[@]}")

# Select Mod
echo -e "\x1b[1;31m=> Select a mod to run:\x1b[0m"
select opt in "${MODS[@]}"; do
	for entry in "${MODS[@]}"; do
		name="${entry%%|*}"
		opt_name="${opt%%|*}"
		if [ "$name" = "$opt_name" ]; then
			path="${entry##*|}"
			if [ "$path" = "none" ]; then
				"$doom_path" -iwad "$wad_path"
			else
				"$doom_path" -iwad "$wad_path" -file "$path"
			fi
			break 2
		fi
	done
done
