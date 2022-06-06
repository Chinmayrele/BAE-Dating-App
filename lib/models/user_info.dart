class UserInfos {
  final String userId;
  final String name;
  final String email;
  final String phoneNo;
  final String gender;
  final String genderChoice;
  final int age;
  final List<dynamic> iLiked;
  final List<dynamic> isViewed;
  final List<dynamic> whoLikedMe;
  final List<dynamic> intersectionLikes;
  final double latitude;
  final double longitude;
  final String about;
  final String interest;
  final String address;
  final List<dynamic> imageUrls;

  UserInfos({
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.gender,
    required this.genderChoice,
    required this.iLiked,
    required this.isViewed,
    required this.whoLikedMe,
    required this.intersectionLikes,
    required this.latitude,
    required this.longitude,
    required this.age,
    required this.about,
    required this.interest,
    required this.address,
    required this.imageUrls,
  });
}
