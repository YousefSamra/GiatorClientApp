class ViewServices {
  int service_id;
  String service_name;
  int doctor_id;
  String full_name;
  int speciality_id;
  String speciality_name;
  String service_price;
  String old_service_price;
  String pic_url;
  ViewServices(
      {this.service_id,
      this.service_name,
      this.doctor_id,
      this.full_name,
      this.speciality_id,
      this.speciality_name,
      this.service_price,
      this.old_service_price,
      this.pic_url});

  factory ViewServices.fromJson(Map<String, dynamic> json) {
    return ViewServices(
        service_id: json['view']['service_id'],
        service_name: json['view']['service_name'],
        doctor_id: json['view']['doctor_id'],
        full_name: json['view']['full_name'],
        speciality_id: json['view']['speciality_id'],
        speciality_name: json['view']['speciality_name'],
        service_price: json['view']['service_price'],
        old_service_price: json['view']['old_service_price'],
        pic_url: json['view']['pic_url']);
  }
}
