class BookVisit {
  String status;
  String message;

  BookVisit({this.status, this.message});
  factory BookVisit.fromJson(Map<String, dynamic> json) {
    return BookVisit(status: json["status"], message: json["message"]);
  }
}
