import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

IconTheme _svgAsset(String assetName) {
  final path = 'assets/icons/$assetName';
  return IconTheme(
    data: const IconThemeData(color: Colors.transparent),
    child: SvgPicture.asset(
      path,
    ),
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
  static final icHomeIconUnselected = _svgAsset('ic_home_icon_unselected.svg');
  static final icExploreIconUnselected =
      _svgAsset('ic_explore_icon_unselected.svg');
  static final icLiveIconSelected = _svgAsset('ic_live_icon_selected.svg');
  static final icMyListIconSelected = _svgAsset('ic_my_list_icon_selected.svg');
  static final icProfileIconSelected =
      _svgAsset('ic_profile_icon_selected.svg');
  static final icPlayVideoIcon = _svgAsset('ic_play_video_icon.svg');
  static final icIMDbIcon = _svgAsset('ic_imdb_icon.svg');
  static final icChromeCastIcon = _svgAsset('ic_chrome_cast.svg');
  static final icDownloadIcon = _svgAsset('ic_download.svg');
  static final icStarHalfColored = _svgAsset('ic_star_with_half_colored.svg');
  static final icBookMark = _svgAsset('ic_bookmark.svg');
  static final icSend = _svgAsset('ic_send.svg');
  static final icMoreCircle = _svgAsset('ic_more_circle.svg');
  static final icFilter = _svgAsset('ic_filter.svg');
  static final icSearch = _svgAsset('ic_search.svg');
  static final icDivider = _svgAsset('ic_trailing_divider_icon.svg');
  static final icRecord = _svgAsset('ic_record.svg');
  static final icCalendar = _svgAsset('ic_calendar.svg');
  static final icGlobe = _svgAsset('ic_globe.svg');
  static final icSort = _svgAsset('ic_sort.svg');
  static final icIgIcon = _svgAsset('ig_icon.svg');
}

class AppPngIcons {
  static const String icImdb = 'assets/icons/ic_imdb.png';
}
