#!/bin/bash

# DjangoFlow FluffyChat Setup Script

# Function to display usage information
usage() {
    echo "Usage: $0 <config_file_path>"
    echo "Config file should be a JSON file with the following structure:"
    echo '{
    "package_name": "com.example.myapp",
    "ios_bundle_identifier": "com.example.myapp",
    "project_name": "MyApp"
}'
    exit 1
}

# Check if config file path is provided
if [ "$#" -ne 1 ]; then
    usage
fi

CONFIG_FILE=$1

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Config file not found: $CONFIG_FILE"
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Please install jq to parse JSON."
    exit 1
fi

# Read configuration
PACKAGE_NAME=$(jq -r '.package_name' "$CONFIG_FILE")
IOS_BUNDLE_ID=$(jq -r '.ios_bundle_identifier' "$CONFIG_FILE")
PROJECT_NAME=$(jq -r '.project_name' "$CONFIG_FILE")

# Validate required fields
if [ -z "$PACKAGE_NAME" ] || [ -z "$IOS_BUNDLE_ID" ] || [ -z "$PROJECT_NAME" ]; then
    echo "Error: Missing required fields in config file."
    usage
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)

# Clone DjangoFlow's FluffyChat repository
git clone --depth 1 https://github.com/djangoflow/fluffychat.git "$TEMP_DIR"

# Copy Android and iOS folders
cp -R "$TEMP_DIR/android" .
cp -R "$TEMP_DIR/ios" .

# Clean up temporary directory
rm -rf "$TEMP_DIR"

# Update Android files
sed -i.bak "s/im\.fluffychat\.app/$PACKAGE_NAME/g" android/app/build.gradle
sed -i.bak "s/im\.fluffychat\.app/$PACKAGE_NAME/g" android/app/src/main/AndroidManifest.xml

# Update iOS files
sed -i.bak "s/im\.fluffychat\.app/$IOS_BUNDLE_ID/g" ios/Runner.xcodeproj/project.pbxproj

# Update app name
sed -i.bak "s/FluffyChat/$PROJECT_NAME/g" android/app/src/main/AndroidManifest.xml
sed -i.bak "s/FluffyChat/$PROJECT_NAME/g" ios/Runner/Info.plist

# Remove backup files
find . -name "*.bak" -type f -delete

echo "DjangoFlow FluffyChat native code setup complete!"
echo "Android package name set to: $PACKAGE_NAME"
echo "iOS bundle identifier set to: $IOS_BUNDLE_ID"
echo "Project name set to: $PROJECT_NAME"