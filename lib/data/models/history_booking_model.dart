import 'package:apllication_book_now/data/models/service_model.dart';

class HistoryBookingModel {
  String idBooking;
  String nomorBooking;
  String noLoket;
  String idUser;
  String alamat;
  String idLayanan;
  String jamBooking;
  String tanggal;
  String status;
  String? catatan;
  ServiceModel layanan;
  DateTime createdAt; // Properti baru untuk menyimpan waktu pembuatan

  HistoryBookingModel({
    required this.idBooking,
    required this.nomorBooking,
    required this.noLoket,
    required this.idUser,
    required this.alamat,
    required this.idLayanan,
    required this.jamBooking,
    required this.tanggal,
    required this.status,
    this.catatan,
    required this.layanan,
    required this.createdAt,
  });

  factory HistoryBookingModel.fromJson(Map<String, dynamic> json) {
    return HistoryBookingModel(
      idBooking: json['id_booking'].toString(),
      nomorBooking: json['nomor_booking'].toString(),
      noLoket: json['no_pelayanan'].toString(),
      idUser: json['id_users'].toString(),
      alamat: json['alamat'].toString(),
      idLayanan: json['id_layanan'].toString(),
      jamBooking: json['jam_booking'].toString(),
      tanggal: json['tanggal'].toString(),
      status: json['status'].toString(),
      catatan: json['catatan'].toString(),
      layanan: ServiceModel.fromJson(json['layanan']),
      createdAt: DateTime.parse(json['created_at']), // Parsing waktu dari JSON
    );
  }
}
