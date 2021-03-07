class DoctorWorkingDays {
  int id;
  int doctorId;
  int dayNumber;
  String startTime;
  String endTime;
  String createdAt;
  String updatedAt;
  int sessionId;
  int restrictionId;

  DoctorWorkingDays(
      {this.id,
      this.doctorId,
      this.dayNumber,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt,
      this.sessionId,
      this.restrictionId});
}
