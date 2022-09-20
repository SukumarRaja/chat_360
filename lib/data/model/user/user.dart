class UserModel {
  String? uid;
  String? name;
  String? phone;
  String? username;
  String? status;
  int? state;
  String? profilePhoto;

  UserModel({
    this.uid,
    this.name,
    this.phone,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
  });

  Map toMap(UserModel user) {
    var data = <String, dynamic>{};
    data['id'] = user.uid;
    data['nickname'] = user.name;
    data['phone'] = user.phone;
    data["photoUrl"] = user.profilePhoto;
    return data;
  }

  // Named constructor
  UserModel.fromMap(Map<String, dynamic> mapData) {
    uid = mapData['id'];
    name = mapData['nickname'];
    phone = mapData['phone'];
    profilePhoto = mapData['photoUrl'];
  }
}
