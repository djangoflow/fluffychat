import 'package:flutter/material.dart';

class AppConfigUpdate {
  final String? applicationName;
  final String? applicationWelcomeMessage;
  final String? defaultHomeserver;
  final double? fontSizeFactor;
  final Color? colorSchemeSeed;
  final bool? allowOtherHomeservers;
  final bool? enableRegistration;
  final String? privacyUrl;
  final String? webBaseUrl;
  final bool? renderHtml;
  final bool? hideRedactedEvents;
  final bool? hideUnknownEvents;
  final bool? hideUnimportantStateEvents;
  final bool? separateChatTypes;
  final bool? autoplayImages;
  final bool? sendTypingNotifications;
  final bool? sendPublicReadReceipts;
  final bool? swipeRightToLeftToReply;
  final bool? sendOnEnter;
  final bool? showPresences;
  final bool? experimentalVoip;

  AppConfigUpdate({
    this.applicationName,
    this.applicationWelcomeMessage,
    this.defaultHomeserver,
    this.fontSizeFactor,
    this.colorSchemeSeed,
    this.allowOtherHomeservers,
    this.enableRegistration,
    this.privacyUrl,
    this.webBaseUrl,
    this.renderHtml,
    this.hideRedactedEvents,
    this.hideUnknownEvents,
    this.hideUnimportantStateEvents,
    this.separateChatTypes,
    this.autoplayImages,
    this.sendTypingNotifications,
    this.sendPublicReadReceipts,
    this.swipeRightToLeftToReply,
    this.sendOnEnter,
    this.showPresences,
    this.experimentalVoip,
  });
}
