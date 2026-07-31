import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:code_lock/services/ad_service.dart';

class CodeLockBannerAd extends StatefulWidget {
  const CodeLockBannerAd({Key? key}) : super(key: key);

  @override
  State<CodeLockBannerAd> createState() => _CodeLockBannerAdState();
}

class _CodeLockBannerAdState extends State<CodeLockBannerAd> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    if (!AdService.to.isAdsEnabled || AdService.to.bannerAdUnitId.isEmpty) {
      return;
    }

    _bannerAd = BannerAd(
      adUnitId: AdService.to.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!AdService.to.isAdsEnabled || AdService.to.bannerAdUnitId.isEmpty) {
      return const SizedBox.shrink();
    }

    if (_isLoaded && _bannerAd != null) {
      return Container(
        alignment: Alignment.center,
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    }

    // Return an empty container of the same size while loading
    return const SizedBox(
      height: 50,
      width: double.infinity,
    );
  }
}
