class ServiceModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String time;

  ServiceModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.time});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id_layanan'],
      name: json['nama_layanan'],
      description: json['deskripsi'],
      image: json['gambar'],
      time: json['waktu'],
    );
  }
}
