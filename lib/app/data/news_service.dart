import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiKey = 'pub_56234ba484ee8b5eef8d66d846c5817d69e28';

  static const String _technologyUrl =
      'https://newsdata.io/api/1/news?apikey=$_apiKey&country=id&language=id&category=technology';
  static const String _sportUrl =
      'https://berita-indo-api.vercel.app/v1/cnn-news?category=sport';
  static const String _educationUrl =
      'https://newsdata.io/api/1/news?apikey=$_apiKey&country=id&language=id&category=education';
  static const String _healthUrl =
      'https://newsdata.io/api/1/news?apikey=$_apiKey&country=id&language=id&category=health';

  Future<List<dynamic>> fetchNews(String category) async {
    String url;

    switch (category) {
      case 'technology':
        url = _technologyUrl;
        break;
      case 'sport':
        url = _sportUrl;
        break;
      case 'education':
        url = _educationUrl;
        break;
      case 'health':
        url = _healthUrl;
        break;
      default:
        throw Exception('Invalid category');
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'] ?? [];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
