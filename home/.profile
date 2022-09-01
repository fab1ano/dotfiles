# Add existing bin directories to the PATH

for bin_path in "$HOME/bin" "$HOME/sbin" "$HOME/.local/bin"; do
	if [[ -d $bin_path ]]; then
		echo $PATH | grep -q $bin_path
		if [[ $? -ne 0 ]]; then
			PATH="$bin_path:$PATH"
		fi
	fi
done
