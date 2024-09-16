#!/bin/bash

# Updated DjangoFlow FluffyChat Setup Script

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

cp -R "$TEMP_DIR/android" .
cp -R "$TEMP_DIR/ios" .

rm -rf "$TEMP_DIR"

# Update Android files
find ./android -type f -exec sed -i.bak "s/chat\.fluffy\.fluffychat/$PACKAGE_NAME/g" {} +
find ./android -type f -exec sed -i.bak "s/im\.fluffychat/$GROUP_ID/g" {} +

# Update iOS files
find ./ios -type f -exec sed -i.bak "s/im\.fluffychat\.app/$IOS_BUNDLE_ID/g" {} +

# Update app name
find ./android -type f -exec sed -i.bak "s/FluffyChat/$PROJECT_NAME/g" {} +
find ./ios -type f -exec sed -i.bak "s/FluffyChat/$PROJECT_NAME/g" {} +

# Remove backup files
find . -name "*.bak" -type f -delete

echo "DjangoFlow FluffyChat native code setup complete!"
echo "Android package name set to: $PACKAGE_NAME"
echo "iOS bundle identifier set to: $IOS_BUNDLE_ID"
echo "Project name set to: $PROJECT_NAME"
echo "Group ID set to: $GROUP_ID"