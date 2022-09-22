import 'package:flutter/material.dart';

class DownloadInfoProvider extends ChangeNotifier {
  int totalSize = 0;
  double downloadedPercentage = 0.0;

  calculateDownloaded(
    double newDownloadedPercentage,
    int newTotal,
  ) {
    totalSize = newTotal;
    downloadedPercentage = newDownloadedPercentage;
    notifyListeners();
  }
}
