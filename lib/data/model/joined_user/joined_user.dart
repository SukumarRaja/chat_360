import 'dart:convert';

class JoinedUserModel {
  final String phone;
  final String? name;

  JoinedUserModel({
    required this.phone,
    this.name,
  });

  factory JoinedUserModel.fromJson(Map<String, dynamic> jsonData) {
    return JoinedUserModel(
      phone: jsonData['phone'],
      name: jsonData['name'],
    );
  }

  static Map<String, dynamic> toMap(JoinedUserModel contact) => {
    'phone': contact.phone,
    'name': contact.name,
  };

  static String encode(List<JoinedUserModel> contacts) => json.encode(
    contacts
        .map<Map<String, dynamic>>(
            (contact) => JoinedUserModel.toMap(contact))
        .toList(),
  );

  static List<JoinedUserModel> decode(String contacts) =>
      (json.decode(contacts) as List<dynamic>)
          .map<JoinedUserModel>((item) => JoinedUserModel.fromJson(item))
          .toList();
}
