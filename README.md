# Bulk Metadata Extractor

`bulk-metadata-extractor.sh` is a shell script that automates metadata extraction for all files in a specified directory. This script uses [ExifTool](https://exiftool.org/) to extract metadata and allows you to save the results to an output file.

## Requirements

- **ExifTool**: Ensure ExifTool is installed on your system.
  - Install on Linux:
    ```bash
    sudo apt install exiftool
    ```
  - Install on macOS:
    ```bash
    brew install exiftool
    ```

## Usage

```bash
./bulk-metadata-extractor.sh [-d directory] [-o output_file]
```

### Options
- `-d`: Specifies the directory containing files for metadata extraction. If not specified, the current directory is used by default.
- `-o`: Specifies the name of the output file for saving extracted metadata. If not provided, metadata is displayed directly in the terminal.
- `-w`: Specifies the creation of a text file containing a list of the document Creators/authors. 

### Examples

#### Example: Extract Metadata from Files in a Specific Directory and Display in Terminal
Extract metadata from all files in the `downloaded_files` directory and print results directly to the terminal.

```bash
./bulk-metadata-extractor.sh -d ~/path/to/downloaded_files
```

#### Example 2: Extract Metadata and Save to an Output File
Extract metadata from all files in the `downloaded_files` directory and save the results to `metadata_output.txt`.

```bash
./bulk-metadata-extractor.sh -d ~/path/to/downloaded_files -o metadata_output.txt -w
```

## Script Workflow

1. **Directory Verification**: Checks if the specified directory exists.
2. **Metadata Extraction**: Iterates over each file in the directory and extracts metadata.
3. **Output Handling**:
   - If an output file is specified (`-o`), metadata is saved to the file.
   - If no output file is specified, metadata is printed directly in the terminal.

## Notes
- The script processes all files in the specified directory. Ensure only the files you want to analyze are present in the directory.
- This script is compatible with any file type supported by ExifTool.
