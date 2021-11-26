# Add existing bin directories to the PATH

for path in "$HOME/bin" "$HOME/sbin" "$HOME/.local/bin"; do
	if [[ -d $path ]]; then
		echo $PATH | grep -q $path
		if [[ $? -ne 0 ]]; then
			PATH="$path:$PATH"
		fi
	fi
done
