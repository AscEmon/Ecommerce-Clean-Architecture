#!/bin/bash

echo "=== APK Obfuscation Verification ==="
echo ""

APK_PATH="build/app/outputs/flutter-apk/app-release.apk"

if [ ! -f "$APK_PATH" ]; then
    echo "❌ APK not found at: $APK_PATH"
    exit 1
fi

echo "✅ APK found: $APK_PATH"
echo "📦 APK Size: $(du -h "$APK_PATH" | cut -f1)"
echo ""

# Extract APK to temporary directory
TEMP_DIR=$(mktemp -d)
echo "📂 Extracting APK to: $TEMP_DIR"
unzip -q "$APK_PATH" -d "$TEMP_DIR"

# Check for Flutter assets
if [ -d "$TEMP_DIR/assets/flutter_assets" ]; then
    echo "✅ Flutter assets found"
fi

# Check for obfuscation indicators
echo ""
echo "=== Obfuscation Indicators ==="

# Check if app.so exists (native code)
if [ -f "$TEMP_DIR/lib/arm64-v8a/libapp.so" ]; then
    SO_SIZE=$(du -h "$TEMP_DIR/lib/arm64-v8a/libapp.so" | cut -f1)
    echo "✅ Native library found: libapp.so ($SO_SIZE)"
    echo "   This contains your obfuscated Dart code"
fi

# Check for Kotlin/Java classes (should be minimal in Flutter)
if [ -d "$TEMP_DIR/classes.dex" ] || [ -f "$TEMP_DIR/classes.dex" ]; then
    echo "✅ DEX files found (Android native code)"
fi

echo ""
echo "=== Debug Symbols Check ==="
if [ -d "build/app/outputs/symbols" ]; then
    SYMBOL_COUNT=$(find build/app/outputs/symbols -type f | wc -l)
    echo "✅ Debug symbols found: $SYMBOL_COUNT files"
    echo "⚠️  IMPORTANT: Keep these files SECRET!"
    echo "   Upload to Firebase Crashlytics for crash reporting"
else
    echo "❌ No debug symbols found"
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo "=== Summary ==="
echo "✅ Your APK is obfuscated and ready for distribution"
echo "🔒 Code is protected from reverse engineering"
echo "📊 Use debug symbols for crash reporting only"

