class DoctorServices {
  var id;
  var service_price;
  var old_service_price;
  var is_available;
  var created_at;
  var updated_at;
  var deleted_at;
  var user_id;
  var service_id;

  DoctorServices(
      {this.id,
      this.service_price,
      this.is_available,
      this.created_at,
      this.updated_at,
      this.deleted_at,
      this.user_id,
      this.service_id,
      this.old_service_price});
}
