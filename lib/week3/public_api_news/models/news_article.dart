class NewsArticle {
  final int id;
  final String title;
  final String author;
  final String category;
  final String summary;
  final String url;
  final DateTime publishedAt;
  final int score;
  final int commentsCount;

  NewsArticle({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.summary,
    required this.url,
    required this.publishedAt,
    this.score = 0,
    this.commentsCount = 0,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Untitled Article',
      author: json['by'] as String? ?? json['author'] as String? ?? 'Anonymous',
      category: json['category'] as String? ?? 'Tech',
      summary: json['text'] as String? ?? json['summary'] as String? ?? 'Click to read full coverage and details.',
      url: json['url'] as String? ?? '',
      publishedAt: json['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch((json['time'] as int) * 1000)
          : DateTime.now(),
      score: json['score'] as int? ?? 1,
      commentsCount: json['descendants'] as int? ?? 0,
    );
  }
}
