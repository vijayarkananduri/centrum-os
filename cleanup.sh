#!/bin/bash

# Remove unnecessary files that are not needed for distribution

echo "Centrum OS - Cleaning Distribution Files"
echo "========================================="
echo ""
echo "Files to remove:"
echo "  - DOWNLOAD.md (info merged to README)"
echo "  - CONFIG_REFERENCE.md (info in docs)"
echo "  - PROJECT_CENTRUM_v1.0.md (archived in GitHub)"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -f DOWNLOAD.md
    rm -f CONFIG_REFERENCE.md
    rm -f PROJECT_CENTRUM_v1.0.md
    echo "Cleanup complete!"
    echo "Remaining files:"
    ls -1 *.md
fi
