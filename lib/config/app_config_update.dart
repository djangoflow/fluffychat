import 'package:flutter/material.dart';

class AppConfigUpdate {
  final String? applicationName;
  final String? applicationWelcomeMessage;
  final String? defaultHomeserver;
  final double? fontSizeFactor;
  final Color? colorSchemeSeed;
  final double? messageFontSize;
  final bool? allowOtherHomeservers;
  final bool? enableRegistration;
  final Color? primaryColor;
  final Color? primaryColorLight;
  final Color? secondaryColor;
  final String? privacyUrl;
  final String? enablePushTutorial;
  final String? encryptionTutorial;
  final String? startChatTutorial;
  final String? appId;
  final String? appOpenUrlScheme;
  final String? webBaseUrl;
  final String? sourceCodeUrl;
  final String? supportUrl;
  final String? changelogUrl;
  final Uri? newIssueUrl;
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
  final bool? hideTypingUsernames;
  final bool? hideAllStateEvents;
  final String? inviteLinkPrefix;
  final String? deepLinkPrefix;
  final String? schemePrefix;
  final String? pushNotificationsChannelId;
  final String? pushNotificationsAppId;
  final String? pushNotificationsGatewayUrl;
  final String? pushNotificationsPusherFormat;
  final String? emojiFontName;
  final String? emojiFontUrl;

  AppConfigUpdate({
    this.applicationName,
    this.applicationWelcomeMessage,
    this.defaultHomeserver,
    this.fontSizeFactor,
    this.colorSchemeSeed,
    this.messageFontSize,
    this.allowOtherHomeservers,
    this.enableRegistration,
    this.primaryColor,
    this.primaryColorLight,
    this.secondaryColor,
    this.privacyUrl,
    this.enablePushTutorial,
    this.encryptionTutorial,
    this.startChatTutorial,
    this.appId,
    this.appOpenUrlScheme,
    this.webBaseUrl,
    this.sourceCodeUrl,
    this.supportUrl,
    this.changelogUrl,
    this.newIssueUrl,
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
    this.hideTypingUsernames,
    this.hideAllStateEvents,
    this.inviteLinkPrefix,
    this.deepLinkPrefix,
    this.schemePrefix,
    this.pushNotificationsChannelId,
    this.pushNotificationsAppId,
    this.pushNotificationsGatewayUrl,
    this.pushNotificationsPusherFormat,
    this.emojiFontName,
    this.emojiFontUrl,
  });
}
