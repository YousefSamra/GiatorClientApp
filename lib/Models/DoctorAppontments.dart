class DoctorAppontments {
  var id;
  var booking_date;
  var booking_start_time;
  var booking_end_time;
  var price;
  var client_is_patient;
  var patient_first_name;
  var patient_last_name;
  var client_address;
  var visit_status_id;
  var is_fees_transfered;
  var is_manual_payment;
  var calculated;
  var created_at;
  var updated_at;
  var deleted_at;
  var user_id;
  var doctor_id;
  var service_id;
  var patient_gender_id;
  var visit_status_name;
  var service_name;
  var patient_name;
  DoctorAppontments(
      {this.id,
      this.booking_date,
      this.booking_start_time,
      this.booking_end_time,
      this.client_is_patient,
      this.client_address,
      this.created_at,
      this.deleted_at,
      this.calculated,
      this.doctor_id,
      this.is_fees_transfered,
      this.is_manual_payment,
      this.patient_first_name,
      this.patient_gender_id,
      this.patient_last_name,
      this.price,
      this.service_id,
      this.updated_at,
      this.user_id,
      this.visit_status_id,
      this.visit_status_name,
      this.service_name,
      this.patient_name});
}
