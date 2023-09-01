# Add existing bin directories to the PATH

bin_paths=("$HOME/bin" "$HOME/sbin" "$HOME/.local/bin")

for bin_path in "${bin_paths[@]}"; do
	# Check if the directory exists
	if [[ -d "$bin_path" ]]; then
		# Check if the bin_path is already in the PATH variable
		if ! echo "$PATH" | grep -q "$bin_path"; then
			PATH="$bin_path:$PATH"
		fi
	fi
done
