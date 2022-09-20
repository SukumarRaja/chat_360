class BroadcastModel {
  Map<String, dynamic> docMap = {};

  BroadcastModel.fromJson(Map<String, dynamic> parsedJSON)
      : docMap = parsedJSON;
}
