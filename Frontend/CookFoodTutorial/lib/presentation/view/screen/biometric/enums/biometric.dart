import 'package:tutorial/res/image/app_image.dart';

enum Biometric { faceId, fingerprint, none }

extension BiometricExt on Biometric {
  String get title {
    switch (this) {
      case Biometric.faceId:
        return 'Bảo mật khuôn mặt';
      case Biometric.fingerprint:
        return 'Bảo mật vân tay';
      case Biometric.none:
        return 'Không hỗ trợ snh trắc học';
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
