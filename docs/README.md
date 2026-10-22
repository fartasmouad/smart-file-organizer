# File Organizer

A simple command-line utility that automatically organizes files into categorized folders based on their file extensions. This project includes two versions: a Windows Batch script (`.bat`) and a Bash script (`.sh`) for Linux.

## Features

- **Automatic file organization:** Sorts files into categories based on their extensions.
- **Multiple categories:** Organizes files into five folders: `images`, `docs`, `videos`, `archives`, and `other`.
- **Automatic directory creation:** Creates the destination folders if they do not already exist.
- **Case-insensitive extension matching:** Recognizes extensions regardless of letter case.
- **Custom target directory:** Accepts the directory to organize as a command-line argument.
- **Directory handling:** Skips directories instead of treating them as files.
- **Cross-platform versions:** Includes scripts for Windows and Linux.

## File Categories

| Category | Supported extensions |
|---|---|
| `images` | `.jpg`, `.jpeg`, `.png`, `.gif`, `.bmp`, `.webp` |
| `docs` | `.pdf`, `.doc`, `.docx`, `.txt`, `.rtf`, `.xls`, `.xlsx`, `.ppt`, `.pptx` |
| `videos` | `.mp4`, `.mkv`, `.avi`, `.mov`, `.wmv` |
| `archives` | `.zip`, `.rar`, `.7z`, `.tar`, `.gz` |
| `other` | All other files, including files without an extension |

## Project Structure

```text
file-organizer/
├── organizer.bat
├── organizer.sh
└── README.md
```

## Requirements

- **Windows:** Command Prompt (CMD), which is available by default.
- **Linux:** Bash and standard command-line utilities, including `mkdir` and `mv`. The script also uses `realpath`.

No additional packages are required on typical modern Linux distributions.

## Usage

### Windows

1. Download or clone the repository.
2. Open Command Prompt.
3. Navigate to the directory containing `organizer.bat`.
4. Run the script with the target directory as an argument:

```bat
organizer.bat "C:\Users\YourName\Downloads"
```

You can also provide a relative path:

```bat
organizer.bat ".\test-folder"
```

### Linux

1. Download or clone the repository.
2. Open a terminal in the project directory.
3. Make the script executable:

```bash
chmod +x organizer.sh
```

4. Run the script with the target directory as an argument:

```bash
./organizer.sh "$HOME/Downloads"
```

You can also use a relative path:

```bash
./organizer.sh "./test-folder"
```

## Example

Suppose the target directory initially contains:

```text
Downloads/
├── photo.jpg
├── report.pdf
├── movie.mp4
├── backup.zip
├── script.py
└── notes.txt
```

After running the organizer, the directory will look like this:

```text
Downloads/
├── images/
│   └── photo.jpg
├── docs/
│   ├── report.pdf
│   └── notes.txt
├── videos/
│   └── movie.mp4
├── archives/
│   └── backup.zip
└── other/
    └── script.py
```

The scripts move files into their corresponding folders; they do not copy them.

## Error Handling

Both versions check whether a target directory was provided and whether it exists before organizing files.

- If no target directory is provided, the script displays usage instructions.
- If the target directory does not exist, the script displays an error and exits.
- The Bash version uses `mv -n` to avoid overwriting existing destination files.
- The Windows Batch version uses the `move` command and does not provide the same explicit no-overwrite option.

## Notes

- Only files directly inside the target directory are organized; subdirectories are not processed recursively.
- Files with unsupported extensions are moved into `other`.
- The Bash version also considers hidden files.
- Existing destination folders are reused.
- File-name conflicts may prevent a file from being moved as expected. The scripts do not automatically rename conflicting files.
