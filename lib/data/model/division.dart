class Division {
  final String id;
  final String name;
  final String bnName;
  final String lat;
  final String long;

  Division({required this.id, required this.name, required this.bnName, required this.lat, required this.long});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json['id'],
      name: json['name'],
      bnName: json['bn_name'],
      lat: json['lat'],
      long: json['long'],
    );
  }
}