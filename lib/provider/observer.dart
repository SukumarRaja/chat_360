import 'package:flutter/material.dart';

import '../config/limit_constants.dart';

class ObserverProvider with ChangeNotifier {
  bool isshowerrorlog = true;
  bool isblocknewlogins = false;
  bool iscallsallowed = true;
  dynamic userAppSettingsDoc;
  bool isTextMessagingAllowed = true;
  bool isMediaMessagingAllowed = true;
  bool isadmobshow = false;
  String? privacyPolicy;
  String? privacyPolicyType;
  String? tnc;
  String? tncType;
  String? androidAppLink;
  String? iosAppLink;
  bool isCallFeatureTotallyHide = LimitConstants.isCallFeatureTotallyHide;
  bool is24hrsTimeformat = LimitConstants.is24hrsTimeformat;
  int groupMemberslimit = LimitConstants.groupMemberslimit;
  int broadcastMemberslimit = LimitConstants.broadcastMemberslimit;
  int statusDeleteAfterInHours = LimitConstants.statusDeleteAfterInHours;
  String feedbackEmail = LimitConstants.feedbackEmail;
  bool isLogoutButtonShowInSettingsPage =
      LimitConstants.isLogoutButtonShowInSettingsPage;
  bool isAllowCreatingGroups = LimitConstants.isAllowCreatingGroups;
  bool isAllowCreatingBroadcasts = LimitConstants.isAllowCreatingBroadcasts;
  bool isAllowCreatingStatus = LimitConstants.isAllowCreatingStatus;
  bool isPercentProgressShowWhileUploading =
      LimitConstants.isPercentProgressShowWhileUploading;
  int maxFileSizeAllowedInMB = LimitConstants.maxFileSizeAllowedInMB;
  int maxNoOfFilesInMultiSharing = LimitConstants.maxNoOfFilesInMultiSharing;
  int maxNoOfContactsSelectForForward =
      LimitConstants.maxNoOfContactsSelectForForward;
  String appShareMessageStringAndroid = '';
  String appShareMessageStringiOS = '';
  bool isCustomAppShareLink = false;

  setObserver({
    bool? getIsShowErrorLog,
    bool? getIsBlockNewLogins,
    bool? getIsCallsAllowed,
    bool? getIsTextMessagingAllowed,
    bool? getIsMediaMessagingAllowed,
    bool? getIsAdmobShow,
    String? getPrivacyPolicy,
    var getUserAppSettingsDoc,
    String? getPrivacyPolicyType,
    String? getTnc,
    String? getTncType,
    String? getAndroidAppLink,
    String? getIosAppLink,
    bool? getIs24hrsTimeFormat,
    int? getGroupMembersLimit,
    int? getBroadcastMembersLimit,
    int? getStatusDeleteAfterInHours,
    String? getFeedbackEmail,
    bool? getIsLogoutButtonShowInSettingsPage,
    bool? getIsCallFeatureTotallyHide,
    bool? getIsAllowCreatingGroups,
    bool? getIsAllowCreatingBroadcasts,
    bool? getIsAllowCreatingStatus,
    bool? getIsPercentProgressShowWhileUploading,
    int? getMaxFileSizeAllowedInMB,
    int? getMaxNoOfFilesInMultiSharing,
    int? getMaxNoOfContactsSelectForForward,
    String? getAppShareMessageStringAndroid,
    String? getAppShareMessageStringiOS,
    bool? getIsCustomAppShareLink,
  }) {
    userAppSettingsDoc = getUserAppSettingsDoc ?? userAppSettingsDoc;
    isshowerrorlog = getIsShowErrorLog ?? isshowerrorlog;
    isblocknewlogins = getIsBlockNewLogins ?? isblocknewlogins;
    iscallsallowed = getIsCallsAllowed ?? iscallsallowed;

    isTextMessagingAllowed =
        getIsTextMessagingAllowed ?? isTextMessagingAllowed;
    isMediaMessagingAllowed =
        getIsMediaMessagingAllowed ?? isMediaMessagingAllowed;
    isadmobshow = getIsAdmobShow ?? isadmobshow;
    privacyPolicy = getPrivacyPolicy ?? privacyPolicy;
    privacyPolicyType = getPrivacyPolicyType ?? privacyPolicyType;
    tnc = getTnc ?? tnc;
    tncType = getTncType ?? tncType;
    androidAppLink = getAndroidAppLink ?? androidAppLink;
    iosAppLink = getIosAppLink ?? iosAppLink;

    is24hrsTimeformat = getIs24hrsTimeFormat ?? is24hrsTimeformat;
    groupMemberslimit = getGroupMembersLimit ?? groupMemberslimit;
    broadcastMemberslimit = getBroadcastMembersLimit ?? broadcastMemberslimit;
    statusDeleteAfterInHours =
        getStatusDeleteAfterInHours ?? statusDeleteAfterInHours;
    feedbackEmail = getFeedbackEmail ?? feedbackEmail;
    isLogoutButtonShowInSettingsPage =
        getIsLogoutButtonShowInSettingsPage ?? isLogoutButtonShowInSettingsPage;
    isCallFeatureTotallyHide =
        getIsCallFeatureTotallyHide ?? isCallFeatureTotallyHide;
    isAllowCreatingGroups = getIsAllowCreatingGroups ?? isAllowCreatingGroups;
    isAllowCreatingBroadcasts =
        getIsAllowCreatingBroadcasts ?? isAllowCreatingBroadcasts;
    isAllowCreatingStatus = getIsAllowCreatingStatus ?? isAllowCreatingStatus;
    isPercentProgressShowWhileUploading =
        getIsPercentProgressShowWhileUploading ??
            isPercentProgressShowWhileUploading;
    maxFileSizeAllowedInMB =
        getMaxFileSizeAllowedInMB ?? maxFileSizeAllowedInMB;
    maxNoOfFilesInMultiSharing =
        getMaxNoOfFilesInMultiSharing ?? maxNoOfFilesInMultiSharing;
    maxNoOfContactsSelectForForward =
        getMaxNoOfContactsSelectForForward ?? maxNoOfContactsSelectForForward;
    appShareMessageStringAndroid =
        getAppShareMessageStringAndroid ?? appShareMessageStringAndroid;
    appShareMessageStringiOS =
        getAppShareMessageStringiOS ?? appShareMessageStringiOS;
    isCustomAppShareLink = getIsCustomAppShareLink ?? isCustomAppShareLink;
    notifyListeners();
  }
}
