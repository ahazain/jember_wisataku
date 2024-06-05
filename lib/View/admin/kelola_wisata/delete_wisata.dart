import 'package:http/http.dart' as http;

class DeleteService {
  static Future<bool> deleteWisata(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/wisata/$id'),
      );
      if (response.statusCode == 200) {
        return true; // Berhasil menghapus
      } else {
        throw Exception('Gagal menghapus wisata'); // Gagal menghapus
      }
    } catch (e) {
      print(e);
      return false; // Gagal menghapus
    }
  }
}