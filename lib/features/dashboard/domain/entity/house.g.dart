// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

House _$HouseFromJson(Map<String, dynamic> json) => House(
    imagePath: json['imagePath'] as String?,
    address: json['address'] as String?,
    crossAxis: json['crossAxis'] ?? 0,
    mainAxis: json['mainAxis'] ?? 0);

Map<String, dynamic> _$HouseToJson(House instance) => <String, dynamic>{
      'imagePath': instance.imagePath,
      'address': instance.address,
      'crossAxis': instance.crossAxis,
      'mainAxis': instance.mainAxis
    };
