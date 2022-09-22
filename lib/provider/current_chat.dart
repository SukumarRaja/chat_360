import 'package:flutter/material.dart';

class CurrentChatProvider extends ChangeNotifier {
  String? peerId = "";
  String? groupChatId = "";

  setPeer({
    String? newPeerId,
    String? newGroupChatId,
  }) {
    peerId = newPeerId ?? peerId;
    groupChatId = newGroupChatId ?? groupChatId;
    notifyListeners();
  }
}
