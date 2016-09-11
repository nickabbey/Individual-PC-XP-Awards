#!/bin/bash
rm -f individualXPawards.ext
cd extension
zip -r ../individualXPawards.ext . -x "*.swp" -x "*/\.DS_Store"
cd ..

