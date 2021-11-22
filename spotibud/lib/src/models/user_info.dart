class UserInfo {
  String? name;
  String? external_urls;
  String? id;
  String? image;
  String? country;

  UserInfo({
    required this.name,
    required this.external_urls,
    required this.id,
    required this.image,
    required this.country,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      name: json['display_name'],
      external_urls: json['external_urls']['spotify'],
      id: json['id'],
      image: json['images'][0]['url'],
      country: json['country'],
    );
  }
}
