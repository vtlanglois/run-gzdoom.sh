#!/bin/bash
echo "Running Doom Sh(ell)"

# Load Config
source "$(dirname "$0")/config.env"

# Select Mod
select opt in "${MODS[@]}"; do
	for entry in "${MODS[@]}"; do
		name="${entry%%|*}"
		opt_name="${opt%%|*}"
		if [ "$name" = "$opt_name" ]; then
			path="${entry##*|}"
			if [ "$path" = "none" ]; then
				"$GZDOOM_PATH" -iwad "$IWAD_PATH"
			else
				"$GZDOOM_PATH" -iwad "$IWAD_PATH" -file "$path"
			fi
			break 2
		fi
	done
done
