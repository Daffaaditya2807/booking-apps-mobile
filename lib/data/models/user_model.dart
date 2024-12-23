class UserModel {
  final int idUsers;
  final String namaPembeli;
  final String email;
  final String username;
  final String phoneNumber;
  final String? phoneToken;
  final String? deviceToken;
  final String avatarUrl;

  UserModel(
      {required this.idUsers,
      required this.namaPembeli,
      required this.email,
      required this.username,
      required this.phoneNumber,
      this.phoneToken,
      this.deviceToken,
      required this.avatarUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        idUsers: json['id_users'],
        namaPembeli: json['nama_pembeli'],
        email: json['email'],
        username: json['username'],
        phoneNumber: json['phone_number'],
        phoneToken: json['phone_token'],
        deviceToken: json['device_token'],
        avatarUrl: json['avatar']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_users': idUsers,
      'nama_pembeli': namaPembeli,
      'email': email,
      'username': username,
      'phone_number': phoneNumber,
      'phone_token': phoneToken,
      'device_token': deviceToken,
      'avatar': avatarUrl
    };
  }
}
