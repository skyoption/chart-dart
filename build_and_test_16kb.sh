#!/bin/bash

# Build and Test 16KB Page Size Compatibility Script
# This script helps verify that your Android app supports 16KB page alignment

set -e

echo "🔧 Building Android App with 16KB Page Size Support"
echo "=================================================="

# Navigate to the example directory
cd "$(dirname "$0")/example"

echo "📱 Cleaning previous builds..."
flutter clean

echo "🔨 Building release APK..."
flutter build apk --release

echo "📦 APK built successfully!"
echo "Location: $(pwd)/build/app/outputs/flutter-apk/app-release.apk"

echo ""
echo "🧪 Running 16KB alignment check..."
if [ -f "../check_elf_alignment.sh" ]; then
    chmod +x ../check_elf_alignment.sh
    ../check_elf_alignment.sh build/app/outputs/flutter-apk/app-release.apk
else
    echo "⚠️  check_elf_alignment.sh not found. Please run it manually:"
    echo "   ./check_elf_alignment.sh example/build/app/outputs/flutter-apk/app-release.apk"
fi

echo ""
echo "✅ Build process completed!"
echo "If the alignment check shows all libraries are properly aligned (2**14 or 2**16),"
echo "your app is ready for Android 15+ 16KB page size requirements."
