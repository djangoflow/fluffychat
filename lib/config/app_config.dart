// ignore_for_file: unnecessary_getters_setters

import 'dart:ui';

import 'package:fluffychat/config/app_config_update.dart';
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
      update: AppConfigUpdate(
        applicationName: json['application_name'],
        applicationWelcomeMessage: json['application_welcome_message'],
        defaultHomeserver: json['default_homeserver'],
        privacyUrl: json['privacy_url'],
        webBaseUrl: json['web_base_url'],
        renderHtml: json['render_html'],
        hideRedactedEvents: json['hide_redacted_events'],
        hideUnknownEvents: json['hide_unknown_events'],
      ),
    );
  }

  static void updateConfig({
    required AppConfigUpdate update,
  }) {
    applicationName = update.applicationName ?? applicationName;
    applicationWelcomeMessage =
        update.applicationWelcomeMessage ?? applicationWelcomeMessage;
    defaultHomeserver = update.defaultHomeserver ?? defaultHomeserver;
    fontSizeFactor = update.fontSizeFactor ?? fontSizeFactor;
    colorSchemeSeed = update.colorSchemeSeed ?? colorSchemeSeed;
    allowOtherHomeservers =
        update.allowOtherHomeservers ?? allowOtherHomeservers;
    enableRegistration = update.enableRegistration ?? enableRegistration;
    privacyUrl = update.privacyUrl ?? privacyUrl;
    webBaseUrl = update.webBaseUrl ?? webBaseUrl;
    renderHtml = update.renderHtml ?? renderHtml;
    hideRedactedEvents = update.hideRedactedEvents ?? hideRedactedEvents;
    hideUnknownEvents = update.hideUnknownEvents ?? hideUnknownEvents;
    hideUnimportantStateEvents =
        update.hideUnimportantStateEvents ?? hideUnimportantStateEvents;
    separateChatTypes = update.separateChatTypes ?? separateChatTypes;
    autoplayImages = update.autoplayImages ?? autoplayImages;
    sendTypingNotifications =
        update.sendTypingNotifications ?? sendTypingNotifications;
    sendPublicReadReceipts =
        update.sendPublicReadReceipts ?? sendPublicReadReceipts;
    swipeRightToLeftToReply =
        update.swipeRightToLeftToReply ?? swipeRightToLeftToReply;
    sendOnEnter = update.sendOnEnter ?? sendOnEnter;
    showPresences = update.showPresences ?? showPresences;
    experimentalVoip = update.experimentalVoip ?? experimentalVoip;
  }
}
