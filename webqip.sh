#!/bin/bash

# Helper to print usage and kill the script
function printUsageAndKill() {
  echo "Usage: $0 -s sourceDirectory -w width -q quality";
  echo "Options:"
  echo "-s: (Required) Source directory in which to search for images."
  echo "-w: The width to use for each low-quality image placeholder."
  echo "-q: The quality at which to output WebP images."
  echo "-h: Displays this help menu."
  kill -INT $$;
}

# No args, abort
if [[ $# -eq 0 ]] ; then
  printUsageAndKill
fi

# Some CLI options for ImageMagick
while getopts s:w:q:h flag
do
    case "${flag}" in
        s) sourceDir=${OPTARG};;
        w) width=${OPTARG};;
        q) quality=${OPTARG};;
        h) printUsageAndKill;;
    esac
done

# Require a source directory
if [[ -z "${sourceDir+x}" ]] ; then
  echo "$0: You must provide a source directory whose images you want to transform."
  printUsageAndKill
fi

# Some defaults
width="${width:-32}"
size="${width}x"
quality="${quality:-75}"

# Remove all previously created placeholders
find . -iregex "${sourceDir}/.*-placeholder\.\(jpg\|png\|webp\)$" -delete

# Empty glob patterns shouldn't be treated as an empty string
# https://unix.stackexchange.com/a/240004/311005
shopt -s nullglob

# Generate 1) LQIPs, and 2) WebP variants
for file in $sourceDir/*.png
do
  convert $file -resize $size "${sourceDir}/`basename $file .png`-placeholder.png"
  convert $file -quality $quality "${sourceDir}/`basename $file .png`.webp"
done

# Generate 1) LQIPs, and 2) WebP variants
for file in $sourceDir/*.jpg
do
  convert $file -resize $size "${sourceDir}/`basename $file .jpg`-placeholder.jpg"
  convert $file -quality $quality "${sourceDir}/`basename $file .jpg`.webp"
done

# Generate LQIPs for any placeholders that were created at run time (in the above loops).
# This is technically doing extra work, but it's not that bad.
for file in $sourceDir/*.webp
do
  convert $file -resize $size "${sourceDir}/`basename $file .webp`-placeholder.webp"
done
