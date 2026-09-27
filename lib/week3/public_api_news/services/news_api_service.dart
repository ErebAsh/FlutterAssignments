import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

/// Public API Service for Week 3 Assignment 1
/// Fetches live news from the official Hacker News Firebase Public REST API
/// (Free, keyless, CORS-enabled, reliable public API).
class NewsApiService {
  static const String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

  Future<List<NewsArticle>> fetchTopArticles({int limit = 15}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/topstories.json'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> storyIds = jsonDecode(response.body) as List<dynamic>;
        final targetIds = storyIds.take(limit).toList();

        final List<NewsArticle> articles = [];
        final futures = targetIds.map((id) => _fetchItem(id as int));
        final results = await Future.wait(futures);

        for (final item in results) {
          if (item != null) {
            articles.add(item);
          }
        }

        if (articles.isNotEmpty) {
          return articles;
        }
      }
      return _getFallbackArticles();
    } catch (_) {
      return _getFallbackArticles();
    }
  }

  Future<NewsArticle?> _fetchItem(int id) async {
    try {
      final res = await http.get(Uri.parse('$_baseUrl/item/$id.json'))
          .timeout(const Duration(seconds: 6));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final title = data['title'] as String? ?? '';
        String category = 'Tech';
        if (title.toLowerCase().contains('ai') || title.toLowerCase().contains('gpt')) {
          category = 'AI';
        } else if (title.toLowerCase().contains('flutter') || title.toLowerCase().contains('dart') || title.toLowerCase().contains('mobile')) {
          category = 'Mobile';
        } else if (title.toLowerCase().contains('security') || title.toLowerCase().contains('bug')) {
          category = 'Security';
        } else if (title.toLowerCase().contains('design') || title.toLowerCase().contains('ui')) {
          category = 'Design';
        }

        data['category'] = category;
        return NewsArticle.fromJson(data);
      }
    } catch (_) {
      // Ignore single item failure
    }
    return null;
  }

  List<NewsArticle> _getFallbackArticles() {
    final now = DateTime.now();
    return [
      NewsArticle(
        id: 101,
        title: 'Flutter 3.38 Released with Enhanced Material 3 Widgets and Impeller',
        author: 'flutter_dev',
        category: 'Mobile',
        summary: 'Deep dive into the latest rendering improvements, multi-platform optimizations, and modern developer tooling.',
        url: 'https://flutter.dev',
        publishedAt: now.subtract(const Duration(hours: 2)),
        score: 342,
        commentsCount: 88,
      ),
      NewsArticle(
        id: 102,
        title: 'Next-Gen Cross-Platform Architecture with Dart and WebAssembly',
        author: 'web_standards',
        category: 'Tech',
        summary: 'How Wasm compilation enables near-native web execution speeds for heavy graphics and state workloads.',
        url: 'https://dart.dev',
        publishedAt: now.subtract(const Duration(hours: 4)),
        score: 219,
        commentsCount: 54,
      ),
      NewsArticle(
        id: 103,
        title: 'State Management in 2026: Balancing Reactivity and Simplicity',
        author: 'architecture_guru',
        category: 'Design',
        summary: 'A comprehensive benchmark of modern reactive UI patterns, ChangeNotifier, and local state lifecycles.',
        url: 'https://news.ycombinator.com',
        publishedAt: now.subtract(const Duration(hours: 7)),
        score: 184,
        commentsCount: 42,
      ),
      NewsArticle(
        id: 104,
        title: 'AI Assisted Mobile Development: Best Practices and Pitfalls',
        author: 'ai_engineer',
        category: 'AI',
        summary: 'Exploring autonomous pair-programming tools and automated unit testing in enterprise Flutter codebases.',
        url: 'https://github.com',
        publishedAt: now.subtract(const Duration(hours: 9)),
        score: 412,
        commentsCount: 110,
      ),
      NewsArticle(
        id: 105,
        title: 'Zero-Trust Mobile Security and API Authentication Guidelines',
        author: 'sec_researcher',
        category: 'Security',
        summary: 'Implementing token rotation, biometrics, and secure encrypted storage on Android and iOS.',
        url: 'https://cve.org',
        publishedAt: now.subtract(const Duration(hours: 12)),
        score: 156,
        commentsCount: 29,
      ),
    ];
  }
}
