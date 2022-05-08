import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final int id;
  @JsonKey(name: 'firstname')
  final String firstName;
  @JsonKey(name: 'lastname')
  final String lastName;
  final String phone;
  final String? image;
  final String email;
  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.image,
    required this.email,
    this.emailVerifiedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  bool get emailVerified => emailVerifiedAt != null;
  String get name => '$firstName $lastName';
}
