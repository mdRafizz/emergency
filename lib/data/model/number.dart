class Number {
  final String id;
  final String upazilla_id;
  final String police_num;
  final String hospital_num;
  final String fire_service;
  final String bus_station;
  final String pharmacy;

  Number({
    required this.id,
    required this.upazilla_id,
    required this.police_num,
    required this.hospital_num,
    required this.fire_service,
    required this.bus_station,
    required this.pharmacy,
  });

  factory Number.fromJson(Map<String, dynamic> json) {
    return Number(
      id: json['id'],
      upazilla_id: json['upazilla_id'],
      police_num: json['police_num'],
      hospital_num: json['hospital_num'],
      fire_service: json['fire_service'],
      bus_station: json['bus_station'],
      pharmacy: json['pharmacy'],
    );
  }
}
