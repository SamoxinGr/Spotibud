class lastNews {
  String? author;
  String? name;
  String? external_urls;
  var images;
  String? type;

  lastNews({
    required this.author,
    required this.name,
    required this.external_urls,
    required this.images,
    required this.type,
  });

  factory lastNews.fromJson(Map<String, dynamic> json) {
    return lastNews(
        author: json['artists'][0]['name'],
        name: json['name'],
        external_urls: json['external_urls']['spotify'],
        images: json['images'][0]['url'],
        type: json['type']);
  }
}
