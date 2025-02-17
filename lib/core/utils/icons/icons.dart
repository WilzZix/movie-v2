import 'package:flutter_svg/flutter_svg.dart';

SvgPicture _svgAsset(String assetName) {
  final path = 'assets/icons/$assetName';
  return SvgPicture.asset(
    path,
  );
}

class AppIcons {
  const AppIcons._();

  static final icAppIcon = _svgAsset('ic_app_icon.svg');
  static final icNotification = _svgAsset('ic_notification.svg');
  static final icHomeIcon = _svgAsset('ic_home_icon.svg');
  static final icExploreIcon = _svgAsset('ic_explore.svg');
  static final icLiveIcon = _svgAsset('ic_live_icon.svg');
  static final icMyListIcon = _svgAsset('ic_mylist_icon.svg');
  static final icProfileIcon = _svgAsset('ic_profile.svg');
}
