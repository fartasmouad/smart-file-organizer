
#!/usr/bin/env bash

set -o nounset

# Get the target folder from the first argument
target="${1:-}"

# Check that a target folder was provided
if [[ -z "$target" ]]; then
    echo "Usage: ${0##*/} \"target_folder\""
    exit 1
fi

# Check that the target folder exists
if [[ ! -d "$target" ]]; then
    echo "Error: Target folder does not exist."
    exit 1
fi

# Convert the target path to an absolute path
target="$(cd -- "$target" && pwd -P)" || exit 1

# Get the script's absolute path
script_path="$(realpath -- "$0")" || exit 1

# Create destination folders
for dir in images docs videos archives other; do
    mkdir -p -- "$target/$dir" || exit 1
done

# Organize files in the target folder
for file in "$target"/* "$target"/.[!.]* "$target"/..?*; do

    # Skip unmatched patterns
    [[ -e "$file" || -L "$file" ]] || continue

    # Skip directories
    [[ -f "$file" ]] || continue

    # Skip the script itself
    [[ "$file" -ef "$script_path" ]] && continue

    # Extract the file extension and convert it to lowercase
    filename="${file##*/}"
    ext="${filename##*.}"
    ext="${ext,,}"

    # Files without an extension go into other
    if [[ "$filename" != *.* || "$filename" == .* && "$filename" != *.*.* ]]; then
        ext=""
    fi

    case "$ext" in
        jpg|jpeg|png|gif|bmp|webp)
            destination="images"
            ;;
        pdf|doc|docx|txt|rtf|xls|xlsx|ppt|pptx)
            destination="docs"
            ;;
        mp4|mkv|avi|mov|wmv)
            destination="videos"
            ;;
        zip|rar|7z|tar|gz)
            destination="archives"
            ;;
        *)
            destination="other"
            ;;
    esac

    # Move the file without overwriting an existing file
    if mv -n -- "$file" "$target/$destination/"; then
        :
    else
        echo "Error: Could not move $filename" >&2
    fi
done

echo "Organization complete!"
exit 0
