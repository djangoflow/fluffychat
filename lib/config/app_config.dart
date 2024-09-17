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
  static Color chatColor = primaryColor;
  static Color? colorSchemeSeed = primaryColor;
  static double messageFontSize = 16.0;
  static bool allowOtherHomeservers = true;
  static bool enableRegistration = true;
  static Color primaryColor = const Color(0xFF5625BA);
  static Color primaryColorLight = const Color(0xFFCCBDEA);
  static Color secondaryColor = const Color(0xFF41a2bc);
  static String _privacyUrl =
      'https://github.com/krille-chan/fluffychat/blob/main/PRIVACY.md';
  static String get privacyUrl => _privacyUrl;
  static set privacyUrl(String value) => _privacyUrl = value;

  static String enablePushTutorial =
      'https://github.com/krille-chan/fluffychat/wiki/Push-Notifications-without-Google-Services';
  static String encryptionTutorial =
      'https://github.com/krille-chan/fluffychat/wiki/How-to-use-end-to-end-encryption-in-FluffyChat';
  static String startChatTutorial =
      'https://github.com/krille-chan/fluffychat/wiki/How-to-Find-Users-in-FluffyChat';
  static String appId = 'im.fluffychat.FluffyChat';
  static String appOpenUrlScheme = 'im.fluffychat';
  static String _webBaseUrl = 'https://fluffychat.im/web';
  static String get webBaseUrl => _webBaseUrl;
  static set webBaseUrl(String value) => _webBaseUrl = value;

  static String sourceCodeUrl = 'https://github.com/krille-chan/fluffychat';
  static String supportUrl = 'https://github.com/krille-chan/fluffychat/issues';
  static String changelogUrl =
      'https://github.com/krille-chan/fluffychat/blob/main/CHANGELOG.md';
  static Uri newIssueUrl = Uri(
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
  static bool hideTypingUsernames = false;
  static bool hideAllStateEvents = false;
  static String inviteLinkPrefix = 'https://matrix.to/#/';
  static String deepLinkPrefix = 'im.fluffychat://chat/';
  static String schemePrefix = 'matrix:';
  static String pushNotificationsChannelId = 'fluffychat_push';
  static String pushNotificationsAppId = 'chat.fluffy.fluffychat';
  static String pushNotificationsGatewayUrl =
      'https://push.fluffychat.im/_matrix/push/v1/notify';
  static String pushNotificationsPusherFormat = 'event_id_only';
  static const String emojiFontName = 'Noto Emoji';
  static const String emojiFontUrl =
      'https://github.com/googlefonts/noto-emoji/';

  // Keep these as const since they're not included in AppConfigUpdate
  static const double borderRadius = 18.0;
  static const double columnWidth = 360.0;
  static final Uri homeserverList = Uri(
    scheme: 'https',
    host: 'servers.joinmatrix.org',
    path: 'servers.json',
  );

  static String clientId = 'im.fluffychat';

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
    _applicationName = update.applicationName ?? _applicationName;
    _applicationWelcomeMessage =
        update.applicationWelcomeMessage ?? _applicationWelcomeMessage;
    _defaultHomeserver = update.defaultHomeserver ?? _defaultHomeserver;
    fontSizeFactor = update.fontSizeFactor ?? fontSizeFactor;
    colorSchemeSeed = update.colorSchemeSeed ?? colorSchemeSeed;
    allowOtherHomeservers =
        update.allowOtherHomeservers ?? allowOtherHomeservers;
    enableRegistration = update.enableRegistration ?? enableRegistration;
    _privacyUrl = update.privacyUrl ?? _privacyUrl;
    _webBaseUrl = update.webBaseUrl ?? _webBaseUrl;
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
    clientId = update.clientId ?? clientId;

    // Update constant primitives if provided
    if (update.messageFontSize != null) {
      messageFontSize = update.messageFontSize!;
    }
    if (update.primaryColor != null) primaryColor = update.primaryColor!;
    if (update.primaryColorLight != null) {
      primaryColorLight = update.primaryColorLight!;
    }
    if (update.secondaryColor != null) secondaryColor = update.secondaryColor!;
    if (update.enablePushTutorial != null) {
      enablePushTutorial = update.enablePushTutorial!;
    }
    if (update.encryptionTutorial != null) {
      encryptionTutorial = update.encryptionTutorial!;
    }
    if (update.startChatTutorial != null) {
      startChatTutorial = update.startChatTutorial!;
    }
    if (update.appId != null) appId = update.appId!;
    if (update.appOpenUrlScheme != null) {
      appOpenUrlScheme = update.appOpenUrlScheme!;
    }
    if (update.sourceCodeUrl != null) sourceCodeUrl = update.sourceCodeUrl!;
    if (update.supportUrl != null) supportUrl = update.supportUrl!;
    if (update.changelogUrl != null) changelogUrl = update.changelogUrl!;
    if (update.newIssueUrl != null) newIssueUrl = update.newIssueUrl!;
    if (update.hideTypingUsernames != null) {
      hideTypingUsernames = update.hideTypingUsernames!;
    }
    if (update.hideAllStateEvents != null) {
      hideAllStateEvents = update.hideAllStateEvents!;
    }
    if (update.inviteLinkPrefix != null) {
      inviteLinkPrefix = update.inviteLinkPrefix!;
    }
    if (update.deepLinkPrefix != null) deepLinkPrefix = update.deepLinkPrefix!;
    if (update.schemePrefix != null) schemePrefix = update.schemePrefix!;
    if (update.pushNotificationsChannelId != null) {
      pushNotificationsChannelId = update.pushNotificationsChannelId!;
    }
    if (update.pushNotificationsAppId != null) {
      pushNotificationsAppId = update.pushNotificationsAppId!;
    }
    if (update.pushNotificationsGatewayUrl != null) {
      pushNotificationsGatewayUrl = update.pushNotificationsGatewayUrl!;
    }
    if (update.pushNotificationsPusherFormat != null) {
      pushNotificationsPusherFormat = update.pushNotificationsPusherFormat!;
    }
  }
}
