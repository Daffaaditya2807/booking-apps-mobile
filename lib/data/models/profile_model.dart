class ProfileModel {
  int id;
  String namaUsaha;
  String logo;
  String warna;

  ProfileModel(
      {required this.id,
      required this.namaUsaha,
      required this.logo,
      required this.warna});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'],
        namaUsaha: json['nama_usaha'],
        logo: json['logo'],
        warna: json['warna']);
  }
}
