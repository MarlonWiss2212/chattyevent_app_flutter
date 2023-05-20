import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomSmallNativeAd extends StatefulWidget {
  final String adUnitId;
  final double width;
  const CustomSmallNativeAd({
    super.key,
    required this.adUnitId,
    required this.width,
  });

  @override
  State<CustomSmallNativeAd> createState() => _CustomSmallNativeAdState();
}

class _CustomSmallNativeAdState extends State<CustomSmallNativeAd> {
  NativeAd? _ad;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      NativeAd(
        adUnitId: widget.adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _ad = ad as NativeAd;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
          templateType: TemplateType.small,
          mainBackgroundColor: Theme.of(context).colorScheme.background,
          cornerRadius: 8,
          callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Theme.of(context).colorScheme.background,
            style: NativeTemplateFontStyle.monospace,
            size: 16.0,
          ),
          primaryTextStyle: NativeTemplateTextStyle(
            textColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Theme.of(context).colorScheme.background,
            style: NativeTemplateFontStyle.italic,
            size: 16.0,
          ),
          secondaryTextStyle: NativeTemplateTextStyle(
            textColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Theme.of(context).colorScheme.background,
            style: NativeTemplateFontStyle.bold,
            size: 16.0,
          ),
          tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: Theme.of(context).colorScheme.onBackground,
            backgroundColor: Theme.of(context).colorScheme.background,
            style: NativeTemplateFontStyle.normal,
            size: 16.0,
          ),
        ),
      ).load();
    });
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ad != null
        ? ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: widget.width,
              minHeight: 80,
              maxWidth: 400,
              maxHeight: 90,
            ),
            child: AdWidget(ad: _ad!),
          )
        : const SizedBox();
  }
}
