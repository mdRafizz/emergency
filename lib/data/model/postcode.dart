class Postcode {
  final String divisionId;
  final String districtId;
  final String upazila;
  final String postOffice;
  final String postCode;

  Postcode({
    required this.divisionId,
    required this.districtId,
    required this.upazila,
    required this.postOffice,
    required this.postCode,
  });

  factory Postcode.fromJson(Map<String, dynamic> json) {
    return Postcode(
      divisionId: json['division_id'],
      districtId: json['district_id'],
      upazila: json['upazila'],
      postOffice: json['postOffice'],
      postCode: json['postCode'],
    );
  }
}
