import 'package:education_apps/app/data/news_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final NewsService _newsService = NewsService();
  List<dynamic> _newsArticles = [];
  String _category = 'technology'; // Default category

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      final articles = await _newsService.fetchNews(_category);
      setState(() {
        _newsArticles = articles;
      });
    } catch (e) {
      print(e);
    }
  }

  void _changeCategory(String category) {
    setState(() {
      _category = category;
      _newsArticles = []; // Clear previous articles
    });
    _fetchNews(); // Fetch news for the selected category
  }

  void _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      print('Attempting to launch URL: $url');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Category buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _changeCategory('technology'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Tech'),
                ),
                ElevatedButton(
                  onPressed: () => _changeCategory('education'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Education'),
                ),
                ElevatedButton(
                  onPressed: () => _changeCategory('health'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Health'),
                ),
                ElevatedButton(
                  onPressed: () => _changeCategory('sport'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Sport'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _newsArticles.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _newsArticles.length,
                    itemBuilder: (context, index) {
                      final article = _newsArticles[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display image if available
                              if (article['image_url'] != null)
                                Container(
                                  width: 100, // Set width for the image
                                  height: 100, // Set height for the image
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(article['image_url']),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                )
                              else
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey[200], // Placeholder color
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              const SizedBox(
                                  width: 10), // Space between image and text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article['title'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2, // Limit title to 2 lines
                                      overflow: TextOverflow
                                          .ellipsis, // Add ellipsis if too long
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      article['description'],
                                      maxLines:
                                          3, // Limit description to 3 lines
                                      overflow: TextOverflow
                                          .ellipsis, // Add ellipsis if too long
                                    ),
                                    const SizedBox(height: 5),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _launchURL(article['link']),
                                      child: const Text('Read More'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
