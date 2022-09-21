import 'dart:async';
import 'package:flutter/material.dart';
import '../config/limit_constants.dart';

class TimerProvider with ChangeNotifier {
  bool wait = false;
  int start = LimitConstants.timeOutSeconds;
  bool isActionBarShow = false;

  startTimer() {
    const onSec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer timer = Timer.periodic(onSec, (timer) {
      if (start == 0) {
        timer.cancel();
        wait = false;
        isActionBarShow = true;
        notifyListeners();
      } else {
        start--;
        wait = true;
        notifyListeners();
      }
    });
  }

  resetTimer() {
    start = LimitConstants.timeOutSeconds;
    isActionBarShow = false;
    notifyListeners();
  }
}
