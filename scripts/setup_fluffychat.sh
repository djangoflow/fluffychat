#!/bin/bash

# FluffyChat Setup Script with Enhanced Validations

set -e

# Function to show a progress message
show_progress() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Function to validate identifier format
validate_identifier() {
    local identifier=$1
    local name=$2
    
    # Check for spaces
    if [[ $identifier =~ \  ]]; then
        echo "Error: $name contains spaces. Spaces are not allowed."
        exit 1
    fi
    
    # Check for hyphens
    if [[ $identifier == *-* ]]; then
        echo "Error: $name contains hyphens. Hyphens are not allowed."
        exit 1
    fi
    
    # Check for valid identifier format (alphanumeric and dots only)
    if ! [[ $identifier =~ ^[a-zA-Z][a-zA-Z0-9\.]*[a-zA-Z0-9]$ ]]; then
        echo "Error: $name is not in a valid format. It should start with a letter, contain only letters, numbers, and dots, and end with a letter or number."
        exit 1
    fi
}

usage() {
    echo "Usage: $0 <config_file_path>"
    echo "Config file should be a JSON file with the following structure:"
    echo '{
    "android_package_name": "com.example.myapp",
    "ios_bundle_identifier": "com.example.myapp",
    "application_name": "MyApp",
    "group_id": "com.example",
    "description": "Your app description here"
}'
    exit 1
}

if [ "$#" -ne 1 ]; then
    usage
fi

CONFIG_FILE=$1

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file not found: $CONFIG_FILE"
    exit 1
fi

show_progress "Checking dependencies..."

if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Please install jq to parse JSON."
    exit 1
fi

if ! command -v perl &> /dev/null; then
    echo "Error: perl is not installed. Please install perl to process files."
    exit 1
fi

show_progress "Reading and validating configuration..."

# Read configuration
ANDROID_PACKAGE_NAME=$(jq -r '.android_package_name' "$CONFIG_FILE")
IOS_BUNDLE_ID=$(jq -r '.ios_bundle_identifier' "$CONFIG_FILE")
APPLICATION_NAME=$(jq -r '.application_name' "$CONFIG_FILE")
GROUP_ID=$(jq -r '.group_id' "$CONFIG_FILE")
DESCRIPTION=$(jq -r '.description' "$CONFIG_FILE")

# Validate required fields
if [ -z "$ANDROID_PACKAGE_NAME" ] || [ -z "$IOS_BUNDLE_ID" ] || [ -z "$APPLICATION_NAME" ] || [ -z "$GROUP_ID" ] || [ -z "$DESCRIPTION" ]; then
    echo "Error: Missing required fields in config file."
    usage
fi

# Validate identifiers
validate_identifier "$ANDROID_PACKAGE_NAME" "Android package name"
validate_identifier "$IOS_BUNDLE_ID" "iOS bundle identifier"
validate_identifier "$GROUP_ID" "Group ID"

show_progress "Configuration validated successfully."

show_progress "Cloning FluffyChat repository..."

TEMP_DIR=$(mktemp -d)
git clone --depth 1 https://github.com/djangoflow/fluffychat.git "$TEMP_DIR"

show_progress "Setting up Android structure..."

# Move FluffyChat Android files to the new structure
ANDROID_SRC_DIR="$TEMP_DIR/android/app/src/main/kotlin/chat/fluffy/fluffychat"
ANDROID_DEST_DIR="./android/app/src/main/kotlin/$(echo $ANDROID_PACKAGE_NAME | sed 's/\./\//g')"
ANDROID_DIR_TO_REMOVE="./android/app/src/main/kotlin/chat"

mkdir -p "$ANDROID_DEST_DIR"
cp -R "$ANDROID_SRC_DIR"/* "$ANDROID_DEST_DIR"

# Copy other Android files
cp -R "$TEMP_DIR/android"/* ./android/

# Remove old Android directory
rm -rf "$ANDROID_DIR_TO_REMOVE"

show_progress "Copying iOS files..."
cp -R "$TEMP_DIR/ios" .

show_progress "Copying web files..."
cp -R "$TEMP_DIR/web" .

show_progress "Copying localization files..."
L10N_SRC_DIR="$TEMP_DIR/assets/l10n"
L10N_DEST_DIR="./assets/l10n"

if [ ! -d "$L10N_DEST_DIR" ]; then
    mkdir -p "$L10N_DEST_DIR"
    show_progress "Created directory: $L10N_DEST_DIR"
fi

cp -R "$L10N_SRC_DIR"/* "$L10N_DEST_DIR"
show_progress "Copied localization files to $L10N_DEST_DIR"

rm -rf "$TEMP_DIR"

# Function to safely process files using Perl
safe_process_file() {
    local file=$1
    perl -p -i -e "s/chat\.fluffy\.fluffychat/$ANDROID_PACKAGE_NAME/g" "$file"
    perl -p -i -e "s/im\.fluffychat(?!\.app)/$GROUP_ID/g" "$file"
    perl -p -i -e "s/im\.fluffychat\.app/$IOS_BUNDLE_ID/g" "$file"
    perl -p -i -e "s/FluffyChat(?! Share)/$APPLICATION_NAME/g" "$file"
}

show_progress "Processing Android files..."
find ./android -type f \( -name "*.xml" -o -name "*.gradle" -o -name "*.java" -o -name "*.kt" -o -name "*.properties" \) | while read file; do
    safe_process_file "$file"
done

show_progress "Processing iOS files..."
find ./ios -type f \( -name "*.plist" -o -name "*.pbxproj" -o -name "*.swift" -o -name "*.h" -o -name "*.m" -o -name "*.entitlements" \) | while read file; do
    if [[ "$file" != *"Runner.xcodeproj/project.pbxproj"* ]]; then
        safe_process_file "$file"
    fi
done

show_progress "Processing Runner.xcodeproj/project.pbxproj..."
if [ -f "./ios/Runner.xcodeproj/project.pbxproj" ]; then
    perl -p -i -e "s/chat\.fluffy\.fluffychat/$ANDROID_PACKAGE_NAME/g" "./ios/Runner.xcodeproj/project.pbxproj"
    perl -p -i -e "s/im\.fluffychat(?!\.app)/$GROUP_ID/g" "./ios/Runner.xcodeproj/project.pbxproj"
    perl -p -i -e "s/im\.fluffychat\.app/$IOS_BUNDLE_ID/g" "./ios/Runner.xcodeproj/project.pbxproj"
fi

show_progress "Processing .entitlements files..."
find ./ios -type f -name "*.entitlements" | while read file; do
    perl -p -i -e "s/group\.im\.fluffychat\.app/group.$IOS_BUNDLE_ID/g" "$file"
done

show_progress "Processing web files..."
find ./web -type f \( -name "*.html" -o -name "*.js" -o -name "*.json" \) | while read file; do
    safe_process_file "$file"
    
    if [[ "$file" == *"index.html"* ]]; then
        perl -p -i -e 's/<meta name="description" content=".*">/<meta name="description" content="'"$DESCRIPTION"'">/g' "$file"
        perl -p -i -e "s/<description>.*<\/description>/<description>$DESCRIPTION<\/description>/g" "$file"
    elif [[ "$file" == *"manifest.json"* ]]; then
        perl -p -i -e 's/"description": ".*"/"description": "'"$DESCRIPTION"'"/g' "$file"
    fi
done

show_progress "Setup complete!"
echo "Android package name set to: $ANDROID_PACKAGE_NAME"
echo "iOS bundle identifier set to: $IOS_BUNDLE_ID"
echo "Application name set to: $APPLICATION_NAME"
echo "Group ID set to: $GROUP_ID"
echo "Description updated in web files"
echo "Localization files copied to $L10N_DEST_DIR"