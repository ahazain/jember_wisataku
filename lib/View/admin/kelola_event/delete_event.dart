import 'package:http/http.dart' as http;

class DeleteEvent {
  static Future<bool> deleteEvent(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.1.72:8000/api/event/$id'),
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
