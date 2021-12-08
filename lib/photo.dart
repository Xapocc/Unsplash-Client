class Photo {
  final String userName;
  final String userProfileImageUrl;
  final String regularImageUrl;
  final String fullImageUrl;

  const Photo({
    required this.userName,
    required this.userProfileImageUrl,
    required this.regularImageUrl,
    required this.fullImageUrl,
  });

  // factory returns new Photo object
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      userName: json['user']['username'].toString(),
      userProfileImageUrl: json['user']['profile_image']['small'].toString(),
      regularImageUrl: json['urls']['regular'].toString(),
      fullImageUrl: json['urls']['full'].toString(),
    );
  }
}