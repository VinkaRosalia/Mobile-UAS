import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/categories_new_model.dart';
import '../models/news_channel_headlines_model.dart';

// Kelas NewsRepository bertanggung jawab untuk mengambil data dari API berita.
class NewsRepository {
  
  // Metode untuk mengambil berita berdasarkan kategori.
  Future<CategoriesNewsModel> fetchNewsCategoires(String category) async {
    String newsUrl =
        'https://newsapi.org/v2/everything?q=$category&apiKey=8a5ec37e26f845dcb4c2b78463734448';
    final response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  // Metode untuk mengambil berita utama dari suatu channel.
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String newsChannel) async {
    String newsUrl =
        'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=8a5ec37e26f845dcb4c2b78463734448';
    final response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}
