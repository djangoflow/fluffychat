#!/bin/bash

# FluffyChat Setup Script with Android Package Restructuring

set -e

usage() {
    echo "Usage: $0 <config_file_path>"
    echo "Config file should be a JSON file with the following structure:"
    echo '{
    "package_name": "com.example.myapp",
    "ios_bundle_identifier": "com.example.myapp",
    "project_name": "MyApp",
    "group_id": "com.example"
}'
    exit 1
}

if [ "$#" -ne 1 ]; then
    usage
fi

CONFIG_FILE=$1

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Config file not found: $CONFIG_FILE"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Please install jq to parse JSON."
    exit 1
fi

if ! command -v perl &> /dev/null; then
    echo "Error: perl is not installed. Please install perl to process files."
    exit 1
fi

if ! command -v flutter &> /dev/null; then
    echo "Error: flutter is not installed. Please install flutter to create the project structure."
    exit 1
fi

# Read configuration
PACKAGE_NAME=$(jq -r '.package_name' "$CONFIG_FILE")
IOS_BUNDLE_ID=$(jq -r '.ios_bundle_identifier' "$CONFIG_FILE")
PROJECT_NAME=$(jq -r '.project_name' "$CONFIG_FILE")
GROUP_ID=$(jq -r '.group_id' "$CONFIG_FILE")

# Validate required fields
if [ -z "$PACKAGE_NAME" ] || [ -z "$IOS_BUNDLE_ID" ] || [ -z "$PROJECT_NAME" ] || [ -z "$GROUP_ID" ]; then
    echo "Error: Missing required fields in config file."
    usage
fi

TEMP_DIR=$(mktemp -d)

git clone --depth 1 https://github.com/djangoflow/fluffychat.git "$TEMP_DIR"

# Move FluffyChat Android files to the new structure
ANDROID_SRC_DIR="$TEMP_DIR/android/app/src/main/kotlin/chat/fluffy/fluffychat"
ANDROID_DEST_DIR="./android/app/src/main/kotlin/$(echo $PACKAGE_NAME | sed 's/\./\//g')"
ANDROID_DIR_TO_REMOVE="./android/app/src/main/kotlin/chat/fluffy/fluffychat"

mkdir -p "$ANDROID_DEST_DIR"
echo "Copying Android files to $ANDROID_DEST_DIR"
cp -R "$ANDROID_SRC_DIR"/* "$ANDROID_DEST_DIR"

# Copy other Android files
cp -R "$TEMP_DIR/android"/* ./android/

# Remove old Android directory
rm -rf "$ANDROID_DIR_TO_REMOVE"

# Copy iOS files
cp -R "$TEMP_DIR/ios" .

rm -rf "$TEMP_DIR"

# Function to safely process files using Perl
safe_process_file() {
    local file=$1
    perl -p -i -e "s/chat\.fluffy\.fluffychat/$PACKAGE_NAME/g" "$file"
    perl -p -i -e "s/im\.fluffychat(?!\.app)/$GROUP_ID/g" "$file"
    perl -p -i -e "s/im\.fluffychat\.app/$IOS_BUNDLE_ID/g" "$file"
    
    # Replace FluffyChat with PROJECT_NAME, but not if it's "FluffyChat Share"
    perl -p -i -e "s/FluffyChat(?! Share)/$PROJECT_NAME/g" "$file"
}

# Update Android files
find ./android -type f \( -name "*.xml" -o -name "*.gradle" -o -name "*.java" -o -name "*.kt" -o -name "*.properties" \) | while read file; do
    safe_process_file "$file"
done

# Update iOS files, including those within FluffyChat Share folder and .entitlements files
find ./ios -type f \( -name "*.plist" -o -name "*.pbxproj" -o -name "*.swift" -o -name "*.h" -o -name "*.m" -o -name "*.entitlements" \) | while read file; do
    if [[ "$file" != *"Runner.xcodeproj/project.pbxproj"* ]]; then
        safe_process_file "$file"
    fi
done

# Special handling for Runner.xcodeproj/project.pbxproj
if [ -f "./ios/Runner.xcodeproj/project.pbxproj" ]; then
    perl -p -i -e "s/chat\.fluffy\.fluffychat/$PACKAGE_NAME/g" "./ios/Runner.xcodeproj/project.pbxproj"
    perl -p -i -e "s/im\.fluffychat(?!\.app)/$GROUP_ID/g" "./ios/Runner.xcodeproj/project.pbxproj"
    perl -p -i -e "s/im\.fluffychat\.app/$IOS_BUNDLE_ID/g" "./ios/Runner.xcodeproj/project.pbxproj"
    # Do not replace FluffyChat with PROJECT_NAME in this file
fi

# Process .entitlements files separately to handle group identifiers
find ./ios -type f -name "*.entitlements" | while read file; do
    perl -p -i -e "s/group\.im\.fluffychat\.app/group.$IOS_BUNDLE_ID/g" "$file"
done

echo "DjangoFlow FluffyChat native code setup complete!"
echo "Android package name set to: $PACKAGE_NAME"
echo "iOS bundle identifier set to: $IOS_BUNDLE_ID"
echo "Project name set to: $PROJECT_NAME"
echo "Group ID set to: $GROUP_ID"