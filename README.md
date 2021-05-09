# webqip

> A simple bash script that uses ImageMagick to generate low-quality image placeholders (LQIPs) and WebP variants of all images in a given directory.

## Installation

1. Install ImageMagick (`sudo apt-get install imagemagick`).
2. Install the WebP libraries: `sudo apt-get install webp` (or [download the binaries](https://developers.google.com/speed/webp/docs/cwebp)).
3. Clone this repo.
4. Make the script executable: `chmod u+x webqip.sh`.
5. Copy the file to `/usr/local/bin`: `sudo cp webqip.sh /usr/local/bin/webqip` (you can rename the script if you want). Alternatively, you may wish to create a symlink to it in case you ever update the script in the future: `sudo ln -s ~/path/to/webqip/webqip.sh /usr/bin/webqip`.

## Usage

| Flag | Description                                     | Required |
|------|-------------------------------------------------|----------|
| `s`  | Source directory in which to search for images. | Yes      |
| `w`  | The width to use for each LQIP                  | No       |
| `q`  | The quality at which to output WebP images      | No       |
| `h`  | Displays the help menu.                         | No       |
