class UserInfo {
  var id;
  var email;
  var deviceToken;
  var genderId;
  var userType;
  var birthDate;
  var mobile;
  var profilePicture;
  var firstName;
  var lastName;

  UserInfo(
      {this.id,
      this.email,
      this.deviceToken,
      this.birthDate,
      this.mobile,
      this.firstName,
      this.lastName,
      this.genderId,
      this.profilePicture,
      this.userType});
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        id: json['id'],
        email: json['email'],
        firstName: json['name'],
        lastName: json['last_name'],
        birthDate: json['birthdate'],
        deviceToken: json['device_token'],
        genderId: json['gender_id'],
        mobile: json['mobile'],
        profilePicture: json['profile_picture'],
        userType: json['user_type']);
  }
}
