import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/logic/data/wonder_data.dart';
import 'package:wondrous_app_clone/logic/data/wonders_data/search/search_data.dart';

part 'search/great_wall_search_data.dart';

class GreatWallData extends WonderData {
  GreatWallData(
      {required super.type,
      required super.title,
      required super.subTitle,
      required super.regionTitle,
      required super.unsplashCollectionId,
      required super.pullQuote1Top,
      required super.pullQuote1Bottom,
      required super.pullQuote1Author,
      required super.historyInfo1,
      required super.historyInfo2,
      required super.constructionInfo1,
      required super.constructionInfo2,
      required super.locationInfo1,
      required super.locationInfo2,
      required super.videoId,
      required super.events});
}
