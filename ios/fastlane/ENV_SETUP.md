Please add .env file in this directory /ios/fastlane with the variables mentioned below

FASTLANE_APPLE_ID="YOUR EMAIL"

# Update AppFile (MUST REQUIRED)

You need to update AppFile for the following fields:

- app_identifier (your ios bundle id)
- itc_team_id (how to find: https://stackoverflow.com/a/58424010/4158349)
- team_id (how to find: https://developer.apple.com/help/account/manage-your-team/locate-your-team-id/)

# Add App specific password if needed for your apple id , ref https://support.apple.com/en-us/102654

FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD="asdsad-asdsad-asdsad"
FASTLANE_PASSWORD="YOUR APPLE ID PASSWORD"
