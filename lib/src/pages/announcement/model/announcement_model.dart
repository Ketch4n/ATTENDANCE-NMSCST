class AnnouncementModel {
  final int id;
  final String subject;
  final String body;
  final String date;

  AnnouncementModel({
    required this.id,
    required this.subject,
    required this.body,
    required this.date,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'],
      subject: json['subject'],
      body: json['body'],
      date: json['created_at'],
    );
  }
}
