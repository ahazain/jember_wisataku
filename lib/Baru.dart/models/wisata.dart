// class Wisata {
//   final int id;
//   final String namaWisata;
//   final String gambar;
//   final int jenisWisataId;
//   final String deskripsi;
//   final String alamat;

//   Wisata({
//     required this.id,
//     required this.namaWisata,
//     required this.gambar,
//     required this.jenisWisataId,
//     required this.deskripsi,
//     required this.alamat,
//   });

//   factory Wisata.fromJson(Map<String, dynamic> json) {
//     return Wisata(
//       id: json['id'],
//       namaWisata: json['nama_wisata'],
//       gambar: json['gambar'],
//       jenisWisataId: json['jenis_wisata_id'],
//       deskripsi: json['deskripsi'] ?? '',
//       alamat: json['alamat'] ?? '',
//     );
//   }
// }
class Wisata {
  final int id;
  final String name;
  final String email;
  final String role;

  Wisata({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory Wisata.fromJson(Map<String, dynamic> json) {
    return Wisata(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}
