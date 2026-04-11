#!/bin/bash
echo "Running Doom Sh(ell)"

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
	echo "Multiple GZDoom versions loaded. Select a GZDoom version:"
fi
doom_path=$(select_option "${GZDOOM_PATH[@]}")

# Select IWAD

if [ "${#IWAD_PATH[@]}" -gt 1 ]; then
	echo "Multiple IWADs versions loaded. Select an IWAD:"
fi
wad_path=$(select_option "${IWAD_PATH[@]}")

# Select Mod
echo "Select a mod to run:"
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
