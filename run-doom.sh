#!/bin/bash
echo "Running Doom Sh(ell)"

# Load Config
source "$(dirname "$0")/config.env"

# Select GZDoom Version
doom_path=$GZDOOM_PATH
if [ "${#GZDOOM_PATH[@]}" -gt 1 ]; then
	echo "Multiple GZDoom versions loaded. Select a GZDoom version:"
	select gz_opt in "${GZDOOM_PATH[@]}"; do
		for entry in "${GZDOOM_PATH[@]}"; do
			name="${entry%%|*}"
			gz_opt_name="${gz_opt%%|*}"
			if [ "$name" = "$gz_opt_name" ]; then
				gz_path="${entry##*|}"
				doom_path="$gz_path"
				break 2
			fi
		done
	done
fi

# Select IWAD
wad_path=$IWAD_PATH
if [ "${#IWAD_PATH[@]}" -gt 1 ]; then
	echo "Multiple IWADs versions loaded. Select an IWAD:"
	select iwad_opt in "${IWAD_PATH[@]}"; do
		for entry in "${IWAD_PATH[@]}"; do
			name="${entry%%|*}"
			iwad_opt_name="${iwad_opt%%|*}"
			if [ "$name" = "$iwad_opt_name" ]; then
				iwad_path="${entry##*|}"
				wad_path="$iwad_path"
				break 2
			fi
		done
	done
fi

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
