import 'package:get/get.dart';
import 'package:education_apps/app/models/technology_article.dart';
import 'package:education_apps/app/models/education_article.dart';
import 'package:education_apps/app/models/sport_article.dart';
import 'package:education_apps/app/models/health_article.dart';
import 'package:education_apps/app/data/news_service.dart';

class NewsController extends GetxController {
  var technologyArticles = <Technology>[].obs;
  var sportArticles = <Sport>[].obs;
  var educationArticles = <Education>[].obs;
  var healthArticles = <Health>[].obs;
  var isLoading = true.obs;
  var selectedCategory = 'technology'.obs;

  final NewsService newsService = NewsService();

  @override
  void onInit() {
    super.onInit();
    fetchArticles(); // Memanggil fetchArticles saat controller diinisialisasi
  }

  void fetchArticles() async {
    isLoading.value = true;

    try {
      List<dynamic> articles;

      switch (selectedCategory.value) {
        case 'technology':
          articles = await newsService.fetchNews('technology');
          technologyArticles
              .assignAll(articles.map((e) => Technology.fromJson(e)).toList());
          break;
        case 'sport':
          articles = await newsService.fetchNews('sport');
          sportArticles
              .assignAll(articles.map((e) => Sport.fromJson(e)).toList());
          break;
        case 'education':
          articles = await newsService.fetchNews('education');
          educationArticles
              .assignAll(articles.map((e) => Education.fromJson(e)).toList());
          break;
        case 'health':
          articles = await newsService.fetchNews('health');
          healthArticles
              .assignAll(articles.map((e) => Health.fromJson(e)).toList());
          break;
      }
    } catch (e) {
      print('Error fetching articles: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
