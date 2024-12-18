import 'package:tutorial/res/image/app_image.dart';

enum Biometric { faceId, fingerprint, none }

extension BiometricExt on Biometric {
  String get title {
    switch (this) {
      case Biometric.faceId:
        return 'faceId';
      case Biometric.fingerprint:
        return 'fingerprint';
      case Biometric.none:
        return 'none';
    }
  }

  String get iconSvg {
    switch (this) {
      case Biometric.faceId:
        return AppImage.icBiometric;
      case Biometric.fingerprint:
        return AppImage.icfinger;
      case Biometric.none:
        return AppImage.icfinger;
    }
  }
}
