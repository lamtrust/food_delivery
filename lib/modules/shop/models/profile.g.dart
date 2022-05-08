// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      id: json['id'] as int,
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String?,
      email: json['email'] as String,
      emailVerifiedAt: json['email_verified_at'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstName,
      'lastname': instance.lastName,
      'phone': instance.phone,
      'image': instance.image,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
    };
