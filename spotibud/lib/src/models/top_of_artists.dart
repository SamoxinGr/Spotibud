class topOfArtists {
  String? external_urls;
  int followers;
  String? href;
  String? id;
  String? images;
  String? name;
  int popularity;
  String? type;
  String? uri;

  topOfArtists({
    required this.external_urls,
    required this.followers,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.popularity,
    required this.type,
    required this.uri,
  });

  factory topOfArtists.fromJson(Map<String, dynamic> json) {
    return topOfArtists(
      external_urls: json['external_urls']['spotify'],
      followers: json['followers']['total'],
      href: json['href'],
      id: json['id'],
      images: json['images'][0]['url'],
      name: json['name'],
      popularity: json['popularity'],
      type: json['type'],
      uri: json['uri'],
    );
  }
}
