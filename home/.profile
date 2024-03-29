# Add existing bin directories to the PATH

# Define bin directory paths
HOME_BIN="$HOME/bin"
HOME_SBIN="$HOME/sbin"
HOME_LOCAL_BIN="$HOME/.local/bin"

# Check each bin directory and add to PATH if necessary
for bin_path in "$HOME_BIN" "$HOME_SBIN" "$HOME_LOCAL_BIN"; do
	# Check if the directory exists
	if [ -d "$bin_path" ]; then
		# Check if the bin_path is already in the PATH variable
		case ":$PATH:" in
			*":$bin_path:"*) ;;
			*) export PATH="$bin_path:$PATH" ;;
		esac
	fi
done
