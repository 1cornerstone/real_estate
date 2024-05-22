import 'package:json_annotation/json_annotation.dart'; 

part 'house.g.dart'; 

@JsonSerializable(nullable: false, ignoreUnannotated: false)
class House {
  @JsonKey(name: 'imagePath')
  String? imagePath;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'crossAxis')
  int? crossAxis;
  @JsonKey(name: 'mainAxis')
  int? mainAxis;

  House({this.imagePath, this.address, this.mainAxis, this.crossAxis});

   factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);

   Map<String, dynamic> toJson() => _$HouseToJson(this);
}

