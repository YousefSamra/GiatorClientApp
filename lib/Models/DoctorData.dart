class DoctorData {
  int id;
  String email;
  String mobile;
  String profile_picture;
  String name;
  String last_name;
  String doctor;

  DoctorData(
      {this.id,
      this.email,
      this.mobile,
      this.profile_picture,
      this.name,
      this.doctor});

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        mobile: json['mobile'],
        doctor: json['doctor'],
        profile_picture: json['profile_picture']);
  }
}
