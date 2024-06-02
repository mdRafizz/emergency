import 'package:hive/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class ContactModel {
  @HiveField(0)
  final String mobileNum;

  @HiveField(1)
  final String name;

  const ContactModel({
    required this.mobileNum,
    required this.name,
  });
}
