class EstablishmentModel {
  final int id;
  final String establishmentName;
  final String latitude;
  final String longitude;
  final String location;
  final String hoursRequired;
  final String radius;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  EstablishmentModel({
    required this.id,
    required this.establishmentName,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.hoursRequired,
    required this.radius,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EstablishmentModel.fromJson(Map<String, dynamic> json) {
    return EstablishmentModel(
      id: json['id'],
      establishmentName: json['establishment_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],
      hoursRequired: json['hours_required'],
      radius: json['radius'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
