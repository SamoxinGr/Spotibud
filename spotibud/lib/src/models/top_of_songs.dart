class topOfSongs {
  String? id;
  String? author;
  String? external_urls;
  String? name;
  String? type;
  String? images;

  topOfSongs({
    required this.id,
    required this.author,
    required this.external_urls,
    required this.name,
    required this.type,
    required this.images,
  });

  factory topOfSongs.fromJson(Map<String, dynamic> json) {
    return topOfSongs(
      id: json['id'],
      author: json['album']['artists'][0]['name'],
      external_urls: json['external_urls']['spotify'],
      name: json['name'],
      type: json['type'],
      images: json['album']['images'][0]['url'],
    );
  }
}
