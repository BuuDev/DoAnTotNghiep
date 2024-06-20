/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Montserrat-Black.ttf
  String get montserratBlack => 'assets/fonts/Montserrat-Black.ttf';

  /// File path: assets/fonts/Montserrat-BlackItalic.ttf
  String get montserratBlackItalic => 'assets/fonts/Montserrat-BlackItalic.ttf';

  /// File path: assets/fonts/Montserrat-Bold.ttf
  String get montserratBold => 'assets/fonts/Montserrat-Bold.ttf';

  /// File path: assets/fonts/Montserrat-BoldItalic.ttf
  String get montserratBoldItalic => 'assets/fonts/Montserrat-BoldItalic.ttf';

  /// File path: assets/fonts/Montserrat-ExtraBold.ttf
  String get montserratExtraBold => 'assets/fonts/Montserrat-ExtraBold.ttf';

  /// File path: assets/fonts/Montserrat-ExtraBoldItalic.ttf
  String get montserratExtraBoldItalic =>
      'assets/fonts/Montserrat-ExtraBoldItalic.ttf';

  /// File path: assets/fonts/Montserrat-ExtraLight.ttf
  String get montserratExtraLight => 'assets/fonts/Montserrat-ExtraLight.ttf';

  /// File path: assets/fonts/Montserrat-ExtraLightItalic.ttf
  String get montserratExtraLightItalic =>
      'assets/fonts/Montserrat-ExtraLightItalic.ttf';

  /// File path: assets/fonts/Montserrat-Italic.ttf
  String get montserratItalic => 'assets/fonts/Montserrat-Italic.ttf';

  /// File path: assets/fonts/Montserrat-Light.ttf
  String get montserratLight => 'assets/fonts/Montserrat-Light.ttf';

  /// File path: assets/fonts/Montserrat-LightItalic.ttf
  String get montserratLightItalic => 'assets/fonts/Montserrat-LightItalic.ttf';

  /// File path: assets/fonts/Montserrat-Medium.ttf
  String get montserratMedium => 'assets/fonts/Montserrat-Medium.ttf';

  /// File path: assets/fonts/Montserrat-MediumItalic.ttf
  String get montserratMediumItalic =>
      'assets/fonts/Montserrat-MediumItalic.ttf';

  /// File path: assets/fonts/Montserrat-Regular.ttf
  String get montserratRegular => 'assets/fonts/Montserrat-Regular.ttf';

  /// File path: assets/fonts/Montserrat-SemiBold.ttf
  String get montserratSemiBold => 'assets/fonts/Montserrat-SemiBold.ttf';

  /// File path: assets/fonts/Montserrat-SemiBoldItalic.ttf
  String get montserratSemiBoldItalic =>
      'assets/fonts/Montserrat-SemiBoldItalic.ttf';

  /// File path: assets/fonts/Montserrat-Thin.ttf
  String get montserratThin => 'assets/fonts/Montserrat-Thin.ttf';

  /// File path: assets/fonts/Montserrat-ThinItalic.ttf
  String get montserratThinItalic => 'assets/fonts/Montserrat-ThinItalic.ttf';

  /// File path: assets/fonts/OFL.txt
  String get ofl => 'assets/fonts/OFL.txt';

  /// File path: assets/fonts/README.txt
  String get readme => 'assets/fonts/README.txt';
}

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/arrow_left_back.svg
  String get arrowLeftBack => 'assets/icon/arrow_left_back.svg';

  /// File path: assets/icon/avatar.png
  AssetGenImage get avatar => const AssetGenImage('assets/icon/avatar.png');

  /// File path: assets/icon/close_icon.svg
  String get closeIcon => 'assets/icon/close_icon.svg';

  /// File path: assets/icon/google.svg
  String get google => 'assets/icon/google.svg';

  /// File path: assets/icon/green.png
  AssetGenImage get green => const AssetGenImage('assets/icon/green.png');

  /// File path: assets/icon/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/icon/logo.png');

  /// File path: assets/icon/ocean.png
  AssetGenImage get ocean => const AssetGenImage('assets/icon/ocean.png');

  /// File path: assets/icon/orange.png
  AssetGenImage get orange => const AssetGenImage('assets/icon/orange.png');

  /// File path: assets/icon/plus.svg
  String get plus => 'assets/icon/plus.svg';

  /// File path: assets/icon/primary.png
  AssetGenImage get primary => const AssetGenImage('assets/icon/primary.png');

  /// File path: assets/icon/red.png
  AssetGenImage get red => const AssetGenImage('assets/icon/red.png');

  /// File path: assets/icon/yellow.png
  AssetGenImage get yellow => const AssetGenImage('assets/icon/yellow.png');
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconGen icon = $AssetsIconGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
