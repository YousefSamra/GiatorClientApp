class DoctorRate {
  int id;
  String booking_date;
  String booking_start_time;
  String booking_end_time;
  String price;
  int client_is_patient;
  String patient_first_name;
  String patient_last_name;
  String client_address;
  String visit_status_id;
  int is_fees_transfered;
  int is_manual_payment;
  int user_id;
  int doctor_id;
  int service_id;
  String rating;
  String comment;
  int avg_doctor_rate;
  int ratings_total;
  String user_name;

  DoctorRate(
      {this.doctor_id,
      this.id,
      this.booking_date,
      this.avg_doctor_rate,
      this.booking_end_time,
      this.booking_start_time,
      this.client_address,
      this.client_is_patient,
      this.comment,
      this.is_fees_transfered,
      this.is_manual_payment,
      this.patient_first_name,
      this.patient_last_name,
      this.price,
      this.rating,
      this.ratings_total,
      this.service_id,
      this.user_id,
      this.user_name});

  factory DoctorRate.fromJson(Map<String, dynamic> json) {
    return DoctorRate(
        id: json['id'],
        doctor_id: json['doctor_id'],
        avg_doctor_rate: json['avg_doctor_rate'],
        booking_date: json['booking_date'],
        booking_end_time: json['booking_end_time'],
        booking_start_time: json['booking_start_time'],
        client_address: json['client_address'],
        client_is_patient: json['client_is_patient'],
        comment: json['comment'],
        is_fees_transfered: json['is_fees_transfered'],
        is_manual_payment: json['is_manual_payment'],
        patient_first_name: json['patient_first_name'],
        patient_last_name: json['patient_last_name'],
        price: json['price'],
        rating: json['rating'],
        ratings_total: json['ratings_total'],
        service_id: json['ratings_total'],
        user_id: json['user_id'],
        user_name: json['user_name']);
  }
}
