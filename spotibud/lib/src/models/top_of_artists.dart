class topOfArtists {
  var external_urls;
  var followers;
  var genres;
  String? href;
  String? id;
  var images;
  String? name;
  var popularity;
  String? type;
  String? uri;

  topOfArtists({
    required this.external_urls,
    required this.followers,
    required this.genres,
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
      genres: json['genres'],
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
