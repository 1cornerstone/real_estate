import 'package:real_estate/core/constant/strings.dart';
import 'package:real_estate/features/dashboard/domain/entity/house.dart';

class GetHouseUseCase {
  static List<House> houses() {
    return [
      House(
          address: 'Gladkova St., 25',
          imagePath: AppStrings.kitchenImage,
          mainAxis: 2,
          crossAxis: 4),
      House(
          address: 'Gubina St., 11',
          imagePath: AppStrings.room2Image,
          mainAxis: 4,
          crossAxis: 2),
      House(
          address: 'Trefoleva St., 43',
          imagePath: AppStrings.roomImage,
          mainAxis: 2,
          crossAxis: 2
      ),
      House(
          address: 'Sedova St., 22',
          imagePath: AppStrings.room3Image,
          mainAxis: 2,
          crossAxis: 2
      ),
    ];
  }
}
