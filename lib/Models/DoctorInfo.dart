class DoctorInfo {
  int id;
  String doctorName;
  String doctorRegistration;
  String clinicPhone;
  String avgDoctorRate;
  String feez;
  String oldFeez;
  int viewCount;
  var picUrl;
  String detailedTitle;
  String detailedInfo;
  String fullAddress;

  DoctorInfo(
      {this.id,
      this.doctorName,
      this.doctorRegistration,
      this.avgDoctorRate,
      this.clinicPhone,
      this.detailedInfo,
      this.detailedTitle,
      this.fullAddress,
      this.viewCount,
      this.feez,
      this.oldFeez,
      this.picUrl});
}
