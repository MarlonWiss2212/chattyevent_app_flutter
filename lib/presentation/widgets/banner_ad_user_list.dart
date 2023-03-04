import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdUserList extends StatefulWidget {
  const BannerAdUserList({super.key});

  @override
  State<BannerAdUserList> createState() => _BannerAdUserListState();
}

class _BannerAdUserListState extends State<BannerAdUserList> {
  BannerAd? _ad;
  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    ).load();
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
        : Container();
  }
}
