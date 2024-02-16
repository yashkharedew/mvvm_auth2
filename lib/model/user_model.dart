class UserModel {
  final String userId;
  final String fullNames;
  final String email;
  UserModel({
    required this.userId,
    required this.fullNames,
    required this.email,
  });

  Map getDataMap() {
    return {
      "userId": userId,
      "fullNames": fullNames,
      "email": email,
    };
  }
}
