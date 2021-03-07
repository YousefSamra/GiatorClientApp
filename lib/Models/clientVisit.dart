import 'dart:convert';

class ClientVisit {
  int id;
  String booking_date;
  String booking_start_time;
  String booking_end_time;
  String price;
  int client_is_patient;
  String patient_first_name;
  String patient_last_name;
  String client_address;
  int visit_status_id;
  int is_fees_transfered;
  int is_manual_payment;
  String calculated;
  String created_at;
  String updated_at;
  String deleted_at;
  int user_id;
  int doctor_id;
  int service_id;
  int patient_gender_id;
  String full_address;
  String service_name;
  String doctor_title;
  String doctor_Name;
  String dayTime;
  String profile_picture;
  String visit_status_name;
  ClientVisit(
      {this.doctor_id,
      this.doctor_Name,
      this.doctor_title,
      this.booking_date,
      this.booking_start_time,
      this.booking_end_time,
      this.client_address,
      this.client_is_patient,
      this.calculated,
      this.dayTime,
      this.full_address,
      this.id,
      this.is_manual_payment,
      this.is_fees_transfered,
      this.patient_first_name,
      this.patient_last_name,
      this.patient_gender_id,
      this.service_id,
      this.service_name,
      this.price,
      this.user_id,
      this.created_at,
      this.updated_at,
      this.deleted_at,
      this.visit_status_id,
      this.profile_picture,
      this.visit_status_name});

  factory ClientVisit.fromJson(Map<String, dynamic> json) {
    return ClientVisit(
        booking_date: json['booking_date'],
        booking_start_time: json['booking_start_time'],
        booking_end_time: json['booking_end_time'],
        client_address: json['client_address'],
        client_is_patient: json['client_is_patient'],
        dayTime: json['dayTime'],
        calculated: json['calculated'],
        created_at: json['created_at'],
        deleted_at: json['deleted_at'],
        doctor_Name: json['doctor_Name'],
        doctor_id: json['doctor_id'],
        doctor_title: json['doctor_title'],
        full_address: json['full_address'],
        id: json['id'],
        is_fees_transfered: json['is_fees_transfered'],
        is_manual_payment: json['is_manual_payment'],
        patient_first_name: json['patient_first_name'],
        patient_gender_id: json['patient_gender_id'],
        patient_last_name: json['patient_last_name'],
        price: json['price'],
        service_id: json['service_id'],
        service_name: json['service_name'],
        updated_at: json['updated_at'],
        user_id: json['user_id'],
        visit_status_id: json['visit_status_id'],
        profile_picture: json['profile_picture'],
        visit_status_name: json['visit_status_name']);
  }
}
