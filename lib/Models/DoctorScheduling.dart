class DoctorScheduling {
  String id;
  int dayNum;
  String dayName;
  var period_times;
  int sessionTime;
  int status;
  String dayNameDate;
  String dayStartTime;
  String dayEndTime;

  DoctorScheduling(
      {this.id,
      this.dayNum,
      this.dayName,
      this.period_times,
      this.dayStartTime,
      this.dayNameDate,
      this.dayEndTime,
      this.sessionTime,
      this.status});
}
