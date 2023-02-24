import 'package:wondrous_app_clone/common_libs.dart';
import 'package:wondrous_app_clone/logic/data/wonder_data.dart';

class WondersLogic {
  List<WonderData> all = [];
  final int timelineStartYear = -3000;
  final int timelineEndYear = 2200;

  WonderData getData(WonderType value) {
    WonderData? result = all.firstWhereOrNull((w) => w.type == value);
    if (result == null) throw ('Could not find data for wonder type $value');
    return result;
  }

  void init() {
    all = [];
  }
}
