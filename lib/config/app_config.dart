// ignore_for_file: unnecessary_getters_setters

import 'dart:ui';

import 'package:matrix/matrix.dart';

abstract class AppConfig {
  static String _applicationName = 'FluffyChat';
  static String get applicationName => _applicationName;
  static set applicationName(String value) => _applicationName = value;

  static String? _applicationWelcomeMessage;
  static String? get applicationWelcomeMessage => _applicationWelcomeMessage;
  static set applicationWelcomeMessage(String? value) =>
      _applicationWelcomeMessage = value;

  static String _defaultHomeserver = 'matrix.org';
  static String get defaultHomeserver => _defaultHomeserver;
  static set defaultHomeserver(String value) => _defaultHomeserver = value;

  static double fontSizeFactor = 1;
  static const Color chatColor = primaryColor;
  static Color? colorSchemeSeed = primaryColor;
  static const double messageFontSize = 16.0;
  static bool allowOtherHomeservers = true;
  static bool enableRegistration = true;
  static const Color primaryColor = Color(0xFF5625BA);
  static const Color primaryColorLight = Color(0xFFCCBDEA);
  static const Color secondaryColor = Color(0xFF41a2bc);
  static String _privacyUrl =
      'https://github.com/krille-chan/fluffychat/blob/main/PRIVACY.md';
  static String get privacyUrl => _privacyUrl;
  static set privacyUrl(String value) => _privacyUrl = value;

  static const String enablePushTutorial =
      'https://github.com/krille-chan/fluffychat/wiki/Push-Notifications-without-Google-Services';
  static const String encryptionTutorial =
      'https://github.com/krille-chan/fluffychat/wiki/How-to-use-end-to-end-encryption-in-FluffyChat';
  static const String startChatTutorial =
      'https://github.com/krille-chan/fluffychat/wiki/How-to-Find-Users-in-FluffyChat';
  static const String appId = 'im.fluffychat.FluffyChat';
  static const String appOpenUrlScheme = 'im.fluffychat';
  static String _webBaseUrl = 'https://fluffychat.im/web';
  static String get webBaseUrl => _webBaseUrl;
  static set webBaseUrl(String value) => _webBaseUrl = value;

  static const String sourceCodeUrl =
      'https://github.com/krille-chan/fluffychat';
  static const String supportUrl =
      'https://github.com/krille-chan/fluffychat/issues';
  static const String changelogUrl =
      'https://github.com/krille-chan/fluffychat/blob/main/CHANGELOG.md';
  static final Uri newIssueUrl = Uri(
    scheme: 'https',
    host: 'github.com',
    path: '/krille-chan/fluffychat/issues/new',
  );
  static bool renderHtml = true;
  static bool hideRedactedEvents = false;
  static bool hideUnknownEvents = true;
  static bool hideUnimportantStateEvents = true;
  static bool separateChatTypes = false;
  static bool autoplayImages = true;
  static bool sendTypingNotifications = true;
  static bool sendPublicReadReceipts = true;
  static bool swipeRightToLeftToReply = true;
  static bool? sendOnEnter;
  static bool showPresences = true;
  static bool experimentalVoip = false;
  static const bool hideTypingUsernames = false;
  static const bool hideAllStateEvents = false;
  static const String inviteLinkPrefix = 'https://matrix.to/#/';
  static const String deepLinkPrefix = 'im.fluffychat://chat/';
  static const String schemePrefix = 'matrix:';
  static const String pushNotificationsChannelId = 'fluffychat_push';
  static const String pushNotificationsAppId = 'chat.fluffy.fluffychat';
  static const String pushNotificationsGatewayUrl =
      'https://push.fluffychat.im/_matrix/push/v1/notify';
  static const String pushNotificationsPusherFormat = 'event_id_only';
  static const String emojiFontName = 'Noto Emoji';
  static const String emojiFontUrl =
      'https://github.com/googlefonts/noto-emoji/';
  static const double borderRadius = 18.0;
  static const double columnWidth = 360.0;
  static final Uri homeserverList = Uri(
    scheme: 'https',
    host: 'servers.joinmatrix.org',
    path: 'servers.json',
  );

  static void loadFromJson(Map<String, dynamic> json) {
    if (json['chat_color'] != null) {
      try {
        colorSchemeSeed = Color(json['chat_color']);
      } catch (e) {
        Logs().w(
          'Invalid color in config.json! Please make sure to define the color in this format: "0xffdd0000"',
          e,
        );
      }
    }
    updateConfig(
      newApplicationName: json['application_name'],
      newApplicationWelcomeMessage: json['application_welcome_message'],
      newDefaultHomeserver: json['default_homeserver'],
      newPrivacyUrl: json['privacy_url'],
      newWebBaseUrl: json['web_base_url'],
      newRenderHtml: json['render_html'],
      newHideRedactedEvents: json['hide_redacted_events'],
      newHideUnknownEvents: json['hide_unknown_events'],
    );
  }

  static void updateConfig({
    String? newApplicationName,
    String? newApplicationWelcomeMessage,
    String? newDefaultHomeserver,
    double? newFontSizeFactor,
    Color? newColorSchemeSeed,
    bool? newAllowOtherHomeservers,
    bool? newEnableRegistration,
    String? newPrivacyUrl,
    String? newWebBaseUrl,
    bool? newRenderHtml,
    bool? newHideRedactedEvents,
    bool? newHideUnknownEvents,
    bool? newHideUnimportantStateEvents,
    bool? newSeparateChatTypes,
    bool? newAutoplayImages,
    bool? newSendTypingNotifications,
    bool? newSendPublicReadReceipts,
    bool? newSwipeRightToLeftToReply,
    bool? newSendOnEnter,
    bool? newShowPresences,
    bool? newExperimentalVoip,
  }) {
    if (newApplicationName != null) applicationName = newApplicationName;
    if (newApplicationWelcomeMessage != null) {
      applicationWelcomeMessage = newApplicationWelcomeMessage;
    }
    if (newDefaultHomeserver != null) defaultHomeserver = newDefaultHomeserver;
    if (newFontSizeFactor != null) fontSizeFactor = newFontSizeFactor;
    if (newColorSchemeSeed != null) colorSchemeSeed = newColorSchemeSeed;
    if (newAllowOtherHomeservers != null) {
      allowOtherHomeservers = newAllowOtherHomeservers;
    }
    if (newEnableRegistration != null) {
      enableRegistration = newEnableRegistration;
    }
    if (newPrivacyUrl != null) privacyUrl = newPrivacyUrl;
    if (newWebBaseUrl != null) webBaseUrl = newWebBaseUrl;
    if (newRenderHtml != null) renderHtml = newRenderHtml;
    if (newHideRedactedEvents != null) {
      hideRedactedEvents = newHideRedactedEvents;
    }
    if (newHideUnknownEvents != null) hideUnknownEvents = newHideUnknownEvents;
    if (newHideUnimportantStateEvents != null) {
      hideUnimportantStateEvents = newHideUnimportantStateEvents;
    }
    if (newSeparateChatTypes != null) separateChatTypes = newSeparateChatTypes;
    if (newAutoplayImages != null) autoplayImages = newAutoplayImages;
    if (newSendTypingNotifications != null) {
      sendTypingNotifications = newSendTypingNotifications;
    }
    if (newSendPublicReadReceipts != null) {
      sendPublicReadReceipts = newSendPublicReadReceipts;
    }
    if (newSwipeRightToLeftToReply != null) {
      swipeRightToLeftToReply = newSwipeRightToLeftToReply;
    }
    if (newSendOnEnter != null) sendOnEnter = newSendOnEnter;
    if (newShowPresences != null) showPresences = newShowPresences;
    if (newExperimentalVoip != null) experimentalVoip = newExperimentalVoip;
  }
}
