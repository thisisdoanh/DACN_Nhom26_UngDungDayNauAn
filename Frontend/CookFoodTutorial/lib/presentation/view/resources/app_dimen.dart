import 'package:get/get.dart';

class AppDimens {
  static const double fontSmallest = 12;
  static const double fontSmall = 16;
  static const double fontMedium = 20;
  static const double fontLarge = 24;
  static const double fontLargest = 36;
  static const double fontHuge = 40;
  static const double sizeImage = 190;
  static const double font10 = 10;
  static const double font14 = 14;

  static const double btnSmall = 20;
  static const double btnMedium = 40;
  static const double iconMoneySize = 30;

  static const double icLogoutSize = 46;
  static const double tittle = 60;
  static const double screenWidthSmall = 360.0;

  static const double width10 = 10;
  static const double height40InSP = 80;
  static const double sizeIcon = 50;
  static const double sizeImageSmall = 30;
  static const double sizeImage35 = 35;
  static const double sizeImageMedium = 70;
  static const double sizeImageBig = 83;
  static const double sizeImageLarge = 200;
  static const double sizeTextSmall = 12;
  static const double sizeTextMedium = 18;

  static const double btnDsIcon = 24;
  static const double btnDefault = 56;
  static const double btnLarge = 70;
  static const double btnQuickCreate = 73;
  static const double btnRecommend = 30;

  static const double sizeIconVerySmall = 12;
  static const double sizeIconSmall = 16;
  static const double sizeIconMedium = 24;
  static const double sizeIconSpinner = 30;
  static const double sizeIconLitterLarge = 32;
  static const double sizeIconLarge = 36;
  static const double sizeIconMoreLarge = 70;
  static const double sizeIconMoreLargeWindow = 100;
  static const double sizeIconExtraLarge = 200;
  static const double sizeDialogNotiIcon = 40;
  static const double sizeBottomSheet = 220;

  static const double heightChip = 30;
  static const double widthChip = 100;
  static const double sizeProduct = 127.0;

  static const int maxLengthDescription = 250;
  static const double dialogMaxWidth = 1000;

  static const double defaultPadding = 16.0;
  static const double paddingVerySmall = 8.0;
  static const double paddingLittleSmall = 10.0;
  static const double paddingDSIcon = 6;
  static const double paddingSmallest = 4.0;
  static const double paddingSmall = 12.0;
  static const double paddingMedium = 20.0;
  static const double paddingLittleLarge = 24.0;
  static const double paddingLarge = 26.0;
  static const double paddingHuge = 32.0;
  static const double paddingItemList = 18.0;
  static const double paddingLabel = 4;
  static const double paddingZero = 0;
  static const double padding2 = 2.0;

  static const double showAppBarDetails = 200;
  static const double sizeAppBarBig = 120;
  static const double sizeAppBarMedium = 92;
  static const double sizeAppBar = 72;
  static const double sizeAppBarSmall = 44;

  static const double sizeGidView = 130;
  static const double sizeGidDesktop = 160;

  static const double sizeBottom = 70;

  static const double heightBoxSearch = 60;
  static const double heightBoxSearchMin = 50;

  static const double sizeLineChart = 4.0;
  static const double sizeIconLineChart = 42.0;
  static const double sizeIconBorderWidth = 2.0;

  // radiusBorder
  static const double radius2 = 2;
  static const double radius4 = 4;
  static const double radius8 = 8;
  static const double radius10 = 10;
  static const double radius16 = 16;

  static const double size5 = 5;
  static const double radius20 = 20;
  static const double radiusDefault = 44;
  static const double borderDefault = 1;
  static const double radius12 = 12;
  // home
  static const double sizeItemNewsHome = 110;
  static const double heightImageLogoHome = 50;
  // divider
  static const double paddingDivider = 15.0;

  // appbar
  static const double paddingSearchBarBig = 50;
  static const double paddingSearchBar = 45;
  static const double paddingSearchBarMedium = 30;
  static const double paddingSearchBarSmall = 10;

  static const double paddingTopScroll = 70;
  static const double paddingTopDefault = 0;

  static double bottomSheetMaxWidth({double? maxWidth}) => double.infinity;
  static double bottomSheetHeight({bool isSecondDisplay = false}) =>
      isSecondDisplay
          ? Get.height / 1.1 - AppDimens.paddingMedium
          : Get.height / 1.1;
}

extension GetSizeScreen on num {
  /// Tỉ lệ fontSize của các textStyle
  double get divSF {
    return this / Get.textScaleFactor;
  }

  // Tăng chiều dài theo font size
  double get mulSF {
    return this * Get.textScaleFactor;
  }
}
