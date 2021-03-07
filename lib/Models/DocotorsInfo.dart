import 'package:flutter/cupertino.dart';

class DoctorsInfo {
  var doctorId;
  var fullName;
  var speciality;
  var specialityId;
  var detailedTitle;
  var fullAddress;
  var fees;
  var avgDoctorREate;
  var doctorRate;
  var ratingsTotal;
  var picUrl;
  var picThumbnail;
  var picPreview;
  var availability;
  var oldFees;

  DoctorsInfo(
      {this.doctorId,
      this.fullName,
      this.speciality,
      this.specialityId,
      this.detailedTitle,
      this.fullAddress,
      this.fees,
      this.avgDoctorREate,
      this.doctorRate,
      this.ratingsTotal,
      this.picUrl,
      this.picThumbnail,
      this.picPreview,
      this.availability,
      this.oldFees});
}
