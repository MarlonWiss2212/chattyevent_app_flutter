import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomBannerAd extends StatefulWidget {
  final String adUnitId;
  const CustomBannerAd({
    super.key,
    required this.adUnitId,
  });

  @override
  State<CustomBannerAd> createState() => _CustomBannerAdState();
}

class _CustomBannerAdState extends State<CustomBannerAd> {
  BannerAd? _ad;
  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      adUnitId: widget.adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ad != null
        ? Container(
            width: _ad!.size.width.toDouble(),
            alignment: Alignment.center,
            height: _ad!.size.height.toDouble(),
            child: AdWidget(ad: _ad!),
          )
        : const SizedBox();
  }
}
