#!/bin/bash
rm -f individualXPawards.ext
cd extension
find . -name ".DS_Store" -delete
zip -r ../individualXPawards.ext . -x "*.swp" -x ".*.swp"
cd ..

